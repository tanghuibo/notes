# spring-boot

## bean 初始化步骤

- 执行构造方法
- 注入 beanName(BeanNameAware)
- 注入 beanFactory(BeanFactoryAware)
- 注入 ApplicationContext(ApplicationContextAware)
- 执行 BeanPostProcessor 的 postProcessBeforeInitialization 方法
- 执行 postConstruct 方法(@PostConstruct)
- 执行 InitializingBean 的 afterPropertiesSet 方法
- 执行 initMethod 方法
- 执行 BeanPostProcessor 的 postProcessAfterInitialization 方法

## 脑图

![avatar](../screenshots/基础篇/spring-boot/spring-boot.png)
