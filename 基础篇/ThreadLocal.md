# ThreadLocal

## 介绍

每个线程都有自己专属的本地变量，不存在多线程问题

## 原理

查看Thread源码

```java
public class Thread implements Runnable {
//与此线程有关的ThreadLocal值。由ThreadLocal类维护
ThreadLocal.ThreadLocalMap threadLocals = null;

//与此线程有关的InheritableThreadLocal值。由InheritableThreadLocal类维护
ThreadLocal.ThreadLocalMap inheritableThreadLocals = null;
}
```

ThreadLocal set方法源码

```java
public void set(T value) {
    Thread t = Thread.currentThread();
    ThreadLocalMap map = getMap(t);
    if (map != null) {
        map.set(this, value);
    } else {
        createMap(t, value);
    }
}

 ThreadLocalMap getMap(Thread t) {
    return t.threadLocals;
}
```

get 源码

```java
public T get() {
    Thread t = Thread.currentThread();
    ThreadLocalMap map = getMap(t);
    if (map != null) {
        ThreadLocalMap.Entry e = map.getEntry(this);
        if (e != null) {
            @SuppressWarnings("unchecked")
            T result = (T)e.value;
            return result;
        }
    }
    return setInitialValue();
}
```

## 内存泄露问题
ThreadLocalMap 中使用的 key 为 ThreadLocal 的弱引用,而 value 是强引用。所以，如果 ThreadLocal 没有被外部强引用的情况下，在垃圾回收的时候，key 会被清理掉，而 value **不会被清理掉**。ThreadLocalMap实现中在调用 set()、get()、remove() 方法的时候，会清理掉 key 为 null 的记录。使用完 ThreadLocal方法后 最好**手动调用remove()方法**。

## InheritableThreadLocal

子线程`创建`创建时copy父线程的本地变量

```java
static InheritableThreadLocal<String> inheritableThreadLocal = new InheritableThreadLocal<>();

public static void main(String[] args) {

    inheritableThreadLocal.set("result1");
    new Thread(() -> {
        try {
            Thread.sleep(500);
            System.out.println("sub thread result:" + inheritableThreadLocal.get());
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }).start();
    inheritableThreadLocal.set("result2");
    System.out.println("main thread result:" + inheritableThreadLocal.get());

}
```

result:

```bash
main thread result:result2
sub thread result:result1
```
