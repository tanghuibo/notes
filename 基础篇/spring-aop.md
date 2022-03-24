# spring aop

## java proxy

## cglib proxy

三个类:

代理类

代理类 fastClass

被代理类 fastClass

代理类 fastClass

### fast-class

被代理类

```java
String sayHello(String name) {
    return "你好:" + name;
}
```

切片

```java
public class BeanInterceptor implements MethodInterceptor {
 
    @Override
    public Object intercept(Object obj, Method method, Object[] params, MethodProxy proxy) throws Throwable {
        System.out.println("调用前");
        // 调用代理对象, 可能造成死循环
        // Object result = proxy.invoke(obj, params);
        Object result = proxy.invokeSuper(obj, params);
        System.out.println(" 调用后" + result);
        return result;
    }
}
```

invokeSuper

```java
public Object invokeSuper(Object obj, Object[] args) throws Throwable {
    try {
        this.init();
        MethodProxy.FastClassInfo fci = this.fastClassInfo;
        return fci.f2.invoke(fci.i2, obj, args); 
    } catch (InvocationTargetException var4) {
        throw var4.getTargetException();
    }
}
```

代理类

```java
final String sayHello(String name) {
    MethodInterceptor methodInterceptor = this.CGLIB$CALLBACK_0;
    if (methodInterceptor == null) {
        CGLIB$BIND_CALLBACKS(this);
        methodInterceptor = this.CGLIB$CALLBACK_0;
    }
    if (methodInterceptor != null) {
        return methodInterceptor.intercept(this, CGLIB$sayHello$0$Method,  new Object[] { name }, CGLIB$sayHello$0$Proxy);
    } else {
        return sayHello(name);
    }
}
```

fastClass

有两个 fastClass,  代理类的 fastClass 被 invoke 调用,  被代理类的 fastClass 被 invokeSuper 调用

```java
//sign方法签名
public int getIndex(String sign){
    switch (sign){
        case "sayHello":
            return 1;
    }
    return 0;
}

//index方法索引， obj调用对象， args方法参数
public Object invoke(int index, Object obj, Object[] args){
    InnerClass innerObj = (InnerClass) obj;
    switch (index){
        case 1:
            return innerObj.sayHello((String)args[0]);
    }
    return null;
}
```

#  objenesis

mock aop 类

[http://objenesis.org/tutorial.html](http://objenesis.org/tutorial.html)

#  手动 aop 补偿

AbstractAdvisorAutoProxyCreator