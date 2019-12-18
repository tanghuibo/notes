# Java8

## 接口默认实现

接口可以有默认实现 (为函数式接口铺路)

```java
interface Test {

    void function1();

    default void defaultFunction() {
        this.function1();
    }
}
```

## Lambda 表达式

1. 可以通过`箭头函数`表示`函数式接口`
2. 可以通过`::`引用方法来表示`函数式接口`

## 函数式接口

接口中只有一个未实现的方法，则可以称为`函数式接口`，可以使用 `FunctionalInterface` 对其进行注释

## 内置接口函数

- Predicates  `boolean test(T t)`
- Function `R apply(T t)`
- Supplier `T get()`
- Consumer `void accept(T t)`
- Comparator `int compare(T t1, T t2)`

## Optionals

防空指针