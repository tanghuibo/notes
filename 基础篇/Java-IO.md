# Java IO

## IO 分类

- 按照流的流向分，可以分为输入流和输出流
- 按照操作单元划分，可以划分为字节流和字符流
- 按照流的角色划分为节点流和处理流

java Io 流共涉及 40 多个类，这些类看上去很杂乱，但实际上很有规则，而且彼此之间存在非常紧密的联系， Java Io 流的 40 多个类都是从如下 4 个抽象类基类中派生出来的。

- InputStream/Reader: 所有的输入流的基类，前者是字节输入流，后者是字符输入流
- OutputStream/Writer: 所有输出流的基类，前者是字节输出流，后者是字符输出流

## NIO

### NIO 和 IO 的区别

- NIO 是面向缓存的，IO 是面向流的
- IO 时阻塞的，NIO 是非阻塞的
- IO 没有选择器，NIO 有

### 读数据和写数据方式

- 从通道进行数据读取：创建一个缓冲区，然后请求通道读取数据。
- 从通道进行数据写入：创建一个缓冲区，填充数据，并要求通道写入数据。

### 核心组件

#### Channels

#### Buffers

Java NIO 从 Channel 中读取数据到 buffers 里，从 Buffer 把数据写入到 Channels；
Buffer 本质上就是一块内存区；
一个 Buffer 有三个属性是必须掌握的，分别是：capacity 容量、position 位置、limit 限制。

#### Selectors

Selector 一般称 为**选择器**或**多路复用器**。它是 Java NIO 核心组件中的一个，用于检查一个或多个 NIO Channel（通道）的状态是否处于可读、可写。如此可以实现单线程管理多个 channels,也就是可以管理多个网络链接。
使用 Selector 的好处在于： 使用更少的线程来就可以来处理通道了， 相比使用多个线程，避免了线程上下文切换带来的开销。

## NIO 写文件

```java
    File file = new File("./test.txt");
        FileChannel fileChannel = FileChannel.open(file.toPath(), StandardOpenOption.CREATE, StandardOpenOption.WRITE);
        ByteBuffer byteBuffer = ByteBuffer.wrap("你好啊".getBytes());
        fileChannel.write(byteBuffer);
```
