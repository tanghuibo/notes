# volatile

## 使用方式

修饰变量

## 作用

1. 保证内存的可见性
2. 防止指令重拍

## 也synchronized 比较

- olatile关键字是线程同步的轻量级实现，所以volatile性能肯定比synchronized关键字要好。
- volatile关键字只能用于变量而synchronized关键字可以修饰方法以及代码块。
- 多线程访问volatile关键字**不会发生阻塞**，而synchronized关键字可能会发生阻塞。
- volatile关键字能保证数据的可见性，但**不能保证数据的原子性**。synchronized关键字两者都能保证。
- volatile关键字主要用于解决变量在多个线程之间的**可见性**，而 synchronized关键字解决的是多个线程之间访问资源的**同步性**。