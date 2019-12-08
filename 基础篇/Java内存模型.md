# Java内存模型

## 内存模型

1.8之前

![avatar](../screenshots/基础篇/Java内存模型/pre-1.8.png)

1.8之后

![avatar](../screenshots/基础篇/Java内存模型/1.8.png)

### 线程私有部分

#### 程序计数器

1. 字节码解释器通过改变程序计数器来依次读取指令，从而实现代码的流程控制，如：顺序执行、选择、循环、异常处理。
2. 在多线程的情况下，程序计数器用于记录当前线程执行的位置，从而当线程被切换回来的时候能够知道该线程上次运行到哪儿了。

#### 虚拟机栈

Java 虚拟机栈是由一个个栈帧组成，而每个栈帧中都拥有:

- 局部变量表
- 操作数栈
- 动态链接
- 方法出口信息

Java 虚拟机栈会出现两种错误:

- StackOverFlowError

> 若 Java 虚拟机栈的内存大小不允许动态扩展，那么当线程请求栈的深度超过当前 Java 虚拟机栈的最大深度的时候，就抛出 StackOverFlowError 错误。

- OutOfMemoryError。

> 若 Java 虚拟机栈的内存大小允许动态扩展，且当线程请求栈时内存用完了，无法再动态扩展了，此时抛出 OutOfMemoryError 错误。

#### 本地方法区

和虚拟机栈所发挥的作用非常相似，区别是： 虚拟机栈为虚拟机执行 Java 方法 （也就是字节码）服务，而本地方法栈则为虚拟机使用到的 Native 方法服务。

## 线程共享部分

- 堆
- 方法区
- 直接内存(非运行时数据区的一部分)

### 堆

#### 分代信息

在 JDK 7 版本及JDK 7 版本之前，堆内存被通常被分为下面三部分：

- 新生代内存(Young Ceneration)

    - Eden
    - From Survivor
    - To Survivor

- 老生代(Old Generation)
- 永久代(Permanent Generation)

JDK 8 版本之后永久代被彻底移除了，取而代之是元空间，元空间使用的是直接内存。

大部分情况，对象都会首先在 Eden 区域分配，在一次新生代垃圾回收后，如果对象还存活，则会进入 s0 或者 s1，并且对象的年龄还会加 1(Eden 区->Survivor 区后对象的初始年龄变为 1)，当它的年龄增加到一定程度（默认为 15 岁），就会被晋升到老年代中。对象晋升到老年代的年龄阈值，可以通过参数 -XX:MaxTenuringThreshold 来设置。

#### 常见异常

- java.lang.OutOfMemoryError: GC Overhead Limit Exceeded

> 当JVM花太多时间执行垃圾回收并且只能回收很少的堆空间时。

- java.lang.OutOfMemoryError: Java heap space

> 在创建新的对象时, 堆内存中的空间不足以存放新创建的对象。(和本机物理内存无关，和你配置的对内存大小有关！)

### 方法区

用于存储已被虚拟机加载的类信息、常量、静态变量、即时编译器编译后的代码等数据。虽然 Java 虚拟机规范把方法区描述为堆的一个逻辑部分，但是它却有一个别名叫做 Non-Heap（非堆），目的应该是与 Java 堆区分开来

方法区也被称为永久代。

### 运行时常量池

![avatar](../screenshots/基础篇/Java内存模型/运行时常量池.jpg)

事例

```java
public class Hello {
    public class Hello {
    String str1 = "hello world test1";
    final Hello H1 = new Hello();
    Hello h2 = new Hello();

    public void test() {
        int a = 123456;
        String b = "hello world test2";
    }
}
```

通过 javap -c -verbose Hello.class 查看字节码信息

```x86asm
Classfile /home/thb/workspace/Hello.class
  Last modified 2019年12月9日; size 442 bytes
  MD5 checksum 5b6148a2eac03c4117214bec18e02c24
  Compiled from "Hello.java"
public class Hello
  minor version: 0
  major version: 56
  flags: (0x0021) ACC_PUBLIC, ACC_SUPER
  this_class: #4                          // Hello
  super_class: #10                        // java/lang/Object
  interfaces: 0, fields: 3, methods: 2, attributes: 1
Constant pool:
   #1 = Methodref          #10.#23        // java/lang/Object."<init>":()V
   #2 = String             #24            // hello world test1
   #3 = Fieldref           #4.#25         // Hello.str1:Ljava/lang/String;
   #4 = Class              #26            // Hello
   #5 = Methodref          #4.#23         // Hello."<init>":()V
   #6 = Fieldref           #4.#27         // Hello.H1:LHello;
   #7 = Fieldref           #4.#28         // Hello.h2:LHello;
   #8 = Integer            123456
   #9 = String             #29            // hello world test2
  #10 = Class              #30            // java/lang/Object
  #11 = Utf8               str1
  #12 = Utf8               Ljava/lang/String;
  #13 = Utf8               H1
  #14 = Utf8               LHello;
  #15 = Utf8               h2
  #16 = Utf8               <init>
  #17 = Utf8               ()V
  #18 = Utf8               Code
  #19 = Utf8               LineNumberTable
  #20 = Utf8               test
  #21 = Utf8               SourceFile
  #22 = Utf8               Hello.java
  #23 = NameAndType        #16:#17        // "<init>":()V
  #24 = Utf8               hello world test1
  #25 = NameAndType        #11:#12        // str1:Ljava/lang/String;
  #26 = Utf8               Hello
  #27 = NameAndType        #13:#14        // H1:LHello;
  #28 = NameAndType        #15:#14        // h2:LHello;
  #29 = Utf8               hello world test2
  #30 = Utf8               java/lang/Object
{
  java.lang.String str1;
    descriptor: Ljava/lang/String;
    flags: (0x0000)

  final Hello H1;
    descriptor: LHello;
    flags: (0x0010) ACC_FINAL

  Hello h2;
    descriptor: LHello;
    flags: (0x0000)

  public Hello();
    descriptor: ()V
    flags: (0x0001) ACC_PUBLIC
    Code:
      stack=3, locals=1, args_size=1
         0: aload_0
         1: invokespecial #1                  // Method java/lang/Object."<init>":()V
         4: aload_0
         5: ldc           #2                  // String hello world test1
         7: putfield      #3                  // Field str1:Ljava/lang/String;
        10: aload_0
        11: new           #4                  // class Hello
        14: dup
        15: invokespecial #5                  // Method "<init>":()V
        18: putfield      #6                  // Field H1:LHello;
        21: aload_0
        22: new           #4                  // class Hello
        25: dup
        26: invokespecial #5                  // Method "<init>":()V
        29: putfield      #7                  // Field h2:LHello;
        32: return
      LineNumberTable:
        line 1: 0
        line 2: 4
        line 3: 10
        line 4: 21

  public void test();
    descriptor: ()V
    flags: (0x0001) ACC_PUBLIC
    Code:
      stack=1, locals=3, args_size=1
         0: ldc           #8                  // int 123456
         2: istore_1
         3: ldc           #9                  // String hello world test2
         5: astore_2
         6: return
      LineNumberTable:
        line 7: 0
        line 8: 3
        line 9: 6
}
SourceFile: "Hello.java"
```

### 元数据区

元空间使用的是直接内存，受本机可用内存的限制，并且永远不会得到 java.lang.OutOfMemoryError。你可以使用 -XX：MaxMetaspaceSize 标志设置最大元空间大小，默认值为 unlimited，这意味着它只受系统内存的限制。-XX：MetaspaceSize 调整标志定义元空间的初始大小如果未指定此标志，则 Metaspace 将根据运行时的应用程序需求动态地重新调整大小。

### 直接内存

直接内存并不是虚拟机运行时数据区的一部分，也不是虚拟机规范中定义的内存区域，但是这部分内存也被频繁地使用。而且也可能导致 OutOfMemoryError 错误出现。
