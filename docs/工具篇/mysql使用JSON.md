# mysql使用JSON

## 问题背景

如果贵公司的线上数据库需要通过一些特定的比较难用的工具去连接才能查询到数据（如阿里的idb），查出来的数据还是csv或者其它的格式……

mysql5.7 之后数据库支持json格式了，返回体可以拼接成json对象或者数组，查询到数据之后可以直接使用，用来做某个借口的参数或者继续加工都是极好的。

## mysql的json函数

| 分类         | 函数               | 描述                                                         |
| :----------- | :----------------- | :----------------------------------------------------------- |
| 创建json     | json_array         | 创建json数组                                                 |
|              | json_object        | 创建json对象                                                 |
|              | json_quote         | 将json转成json字符串类型                                     |
|              | json_arrayagg      | 创建json数组（聚合）和json_array的区别类似与concat和group_concat |
| 查询json     | json_contains      | 判断是否包含某个json值                                       |
|              | json_contains_path | 判断某个路径下是否包json值                                   |
|              | json_extract       | 提取json值                                                   |
|              | column->path       | json_extract的简洁写法，MySQL 5.7.9开始支持                  |
|              | json_keys          | 提取json中的键值为json数组                                   |
|              | json_search        | 按给定字符串关键字搜索json，返回匹配的路径                   |
| 修改json     | json_append        | 废弃，MySQL 5.7.9开始改名为json_array_append                 |
|              | json_array_append  | 末尾添加数组元素，如果原有值是数值或json对象，则转成数组后，再添加元素 |
|              | json_array_insert  | 插入数组元素                                                 |
|              | json_insert        | 插入值（插入新值，但不替换已经存在的旧值）                   |
|              | json_merge         | 合并json数组或对象                                           |
|              | json_remove        | 删除json数据                                                 |
|              | json_replace       | 替换值（只替换已经存在的旧值）                               |
|              | json_set           | 设置值（替换旧值，并插入不存在的新值）                       |
|              | json_unquote       | 去除json字符串的引号，将值转成string类型                     |
| 返回json属性 | json_depth         | 返回json文档的最大深度                                       |
|              | json_length        | 返回json文档的长度                                           |
|              | json_type          | 返回json值得类型                                             |
|              | json_valid         | 判断是否为合法json文档                                       |