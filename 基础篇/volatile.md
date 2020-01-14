# volatile

## 使用方式

修饰变量

## 作用

1. 保证内存的可见性
2. 防止指令重拍

## 与 synchronized 比较

- volatile 关键字是线程同步的轻量级实现，所以 volatile 性能肯定比 synchronized 关键字要好。
- volatile 关键字只能用于变量而 synchronized 关键字可以修饰方法以及代码块。
- 多线程访问 volatile 关键字**不会发生阻塞**，而 synchronized 关键字可能会发生阻塞。
- volatile 关键字能保证数据的可见性，但**不能保证数据的原子性**。synchronized 关键字两者都能保证。
- volatile 关键字主要用于解决变量在多个线程之间的**可见性**，而 synchronized 关键字解决的是多个线程之间访问资源的**同步性**。
