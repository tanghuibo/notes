# Java 线程池

## 使用线程池的好处

- 降低资源消耗
- 提高响应速度
- 提高线程的可管理性

## this 指针逃逸问题

在构造函数返回之前，其他线程已经就持有了该对象的应用，产生的结果自然和预期可能会产生差异。
常见的 this 指针逃逸:

- 在构造函数中注册事件监听
- 在构造函数中启动新线程

存在 this 指针逃逸:

```java
public class TestEscape
{
    private String name;
    public TestEscape(String name) throws InterruptedException
    {

        new Thread(new EscapeRunnable()).start();
        this.name = name;

    }

    private class EscapeRunnable implements Runnable
    {
        @Override
        public void run()
        {
            System.out.println(name);
        }
    }

    public static void main(String[] args) throws InterruptedException
    {
        new TestEscape("woniu");
    }
}
```

改良版:

```java
public class TestEscape
{
    private String name;
    private Thread thread;

    public TestEscape(String name) throws InterruptedException
    {

        thread = new Thread(new EscapeRunnable());
        this.name = name;

    }

    public void init()
    {
        thread.start();
    }

    private class EscapeRunnable implements Runnable
    {
        @Override
        public void run()
        {
            System.out.println(name);
        }
    }

    public static void main(String[] args) throws InterruptedException
    {
       //由于已经将构造函数初始化完成，其后调用的方法，均可以正常执行，与预期无差异。
        new TestEscape("woniu").init();
    }
}
```

## Executor 框架

### Executor 框架三大结构

- 任务(Runable/Callable)
- 任务的执行者(Executor)
- 异步执行结果(Futer)

## ThreadPoolExecutor

```java
 public ThreadPoolExecutor(
     int corePoolSize,//线程池的核心线程数量
     int maximumPoolSize,//线程池的最大线程数
     long keepAliveTime,//当线程数大于核心线程数时，多余的空闲线程存活的最长时间
      TimeUnit unit,//时间单位
      BlockingQueue<Runnable> workQueue,//任务队列，用来储存等待执行任务的队列
      ThreadFactory threadFactory,//线程工厂，用来创建线程，一般默认即可
      RejectedExecutionHandler handler//拒绝策略，当提交的任务过多而不能及时处理时，我们可以定制策略来处理任务
      );
```

| 参数            | 含义                                                                                                                                                                             |
| --------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| corePoolSize    | 核心线程数线程数定义了最小可以同时运行的线程数量。                                                                                                                               |
| maximumPoolSize | 当队列中存放的任务达到队列容量的时候，当前可以同时运行的线程数量变为最大线程数。                                                                                                 |
| workQueue       | 当新任务来的时候会先判断当前运行的线程数量是否达到核心线程数，如果达到的话，信任就会被存放在队列中。                                                                             |
| keepAliveTime   | 当线程池中的线程数量大于 corePoolSize 的时候，如果这时没有新的任务提交，核心线程外的线程不会立即销毁，而是会等待，直到等待的时间超过了 keepAliveTime 才会被回收销毁。            |
| unit            | 销毁时间单位                                                                                                                                                                     |
| threadFactory   | 创建线程使用的工厂                                                                                                                                                               |
| handler         | 饱和策略, AbortPolicy(default): 抛异常拒绝新任务的处理；<br />CallerRunsPolicy: 调用当前线程处理任务；<br />DiscardPolicy: 直接丢弃；<br />DiscardOldestPolicy: 丢弃最早未处理的 |

### Excutors 弊端

- FixedThreadPool 和 SingleThreadExecutor ： 允许请求的队列长度为 Integer.MAX_VALUE,可能堆积大量的请求，从而导致 OOM。
- CachedThreadPool 和 ScheduledThreadPool ： 允许创建的线程数量为 Integer.MAX_VALUE ，可能会创建大量线程，从而导致 OOM。

### Runable VS Callable

- runable 没有返回值，外部不能检查异常信息
- 两者可以通过 Excutors 进行转换

### execute() VS submit()

- execute 没有返回值，submit 有
- execute 只能接受 Runable，submit 可以接受 Runable、Callable

### shutdown() VS shutdownNow()

- shutdown（）: 关闭线程池，线程池的状态变为 SHUTDOWN。线程池不再接受新任务了，但是队列里的任务得执行完毕。

- shutdownNow（）: 关闭线程池，线程的状态变为 STOP。线程池会终止当前正在运行的任务，并停止处理排队的任务并返回正在等待执行人任务。

### isTerminated() VS isShutdown()

- isShutDown 当调用 shutdown() 方法后返回为 true。
- isTerminated 当调用 shutdown() 方法后，并且没有任务需要被处理。
