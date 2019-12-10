# Java常量池

## String类和常量池

### String对象两种创建方法

```java
//在常量池中拿对象
String str1 = "str";
//直接在堆内存空间创建一个新的对象
String str2 = new String("str");
```

只要使用 `new` 方法，便需要**创建新对象**。

### 会创建几个对象?

```Java
String str = "hello" + " my name is Bob";
```

或

```java
final String str = "hello";
final String str2 = " my name is Bob";
String str3 = str + str2;
```

> 编译后变成常量  "hello my name is Bob"

但

```java
String str = "hello";
String str2 = " my name is Bob";
String str3 = str + str2;
```

中 str3 不会被编译成常量

```x86asm
...
Constant pool:
  ...
  #13 = Utf8               hello my name is Bob
  ...
...
```

### String s1 = new String("abc");这句话创建了几个字符串对象？

将创建 1 或 2 个字符串。如果池中已存在字符串常量“abc”，则只会在堆空间创建一个字符串常量“abc”。如果池中没有字符串常量“abc”，那么它将首先在池中创建，然后在堆空间中创建，因此将创建总共 2 个字符串对象。

## 8 种基本类型的包装类和常量池

Java 基本类型的包装类的大部分都实现了常量池技术，即 Byte,Short,Integer,Long,Character,Boolean；这 5 种包装类默认创建了数值[-128，127] 的相应类型的缓存数据，但是超出此范围仍然会去创建新的对象。

```java
Integer i1 = 129;
Integer i2 = 129;

Integer i3 = 121;
Integer i4 = 121;

System.out.println(i1 == i2); // false
System.out.println(i3 == i4); // true
```

### 以 `Integer` 为例

```java
Integer i = 150;
```

转成字节码之后:

```x86asm
...
3: invokestatic  #2                  // Method java/lang/Integer.valueOf:(I)Ljava/lang/Integer;
...
```

Intger i = 150 => Integer i = Integer.value(150)

Integer.value 源码

```java
static final int low = -128;
// 127
static final int high;

static {
    // high value may be configured by property
    int h = 127;
    String integerCacheHighPropValue =
        VM.getSavedProperty("java.lang.Integer.IntegerCache.high");
    if (integerCacheHighPropValue != null) {
        try {
            h = Math.max(parseInt(integerCacheHighPropValue), 127);
            // Maximum array size is Integer.MAX_VALUE
            h = Math.min(h, Integer.MAX_VALUE - (-low) -1);
        } catch( NumberFormatException nfe) {
            // If the property cannot be parsed into an int, ignore it.
        }
    }
    high = h;
    ...
}

@HotSpotIntrinsicCandidate
public static Integer valueOf(int i) {
    if (i >= IntegerCache.low && i <= IntegerCache.high)
        return IntegerCache.cache[i + (-IntegerCache.low)];
    return new Integer(i);
}
```