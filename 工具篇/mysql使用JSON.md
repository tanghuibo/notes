# mysql 使用 JSON

## 问题背景

如果贵公司的线上数据库需要通过一些特定的比较难用的工具去连接才能查询到数据（如阿里的 idb），查出来的数据还是 csv 或者其它的格式……

mysql5.7 之后数据库支持 json 格式了，返回体可以拼接成 json 对象或者数组，查询到数据之后可以直接使用，用来做某个借口的参数或者继续加工都是极好的。

## mysql 的 json 函数

| 分类           | 函数               | 描述                                                                     |
| :------------- | :----------------- | :----------------------------------------------------------------------- |
| 创建 json      | json_array         | 创建 json 数组                                                           |
|                | json_object        | 创建 json 对象                                                           |
|                | json_quote         | 将 json 转成 json 字符串类型                                             |
|                | json_arrayagg      | 创建 json 数组（聚合）和 json_array 的区别类似与 concat 和 group_concat  |
| 查询 json      | json_contains      | 判断是否包含某个 json 值                                                 |
|                | json_contains_path | 判断某个路径下是否包 json 值                                             |
|                | json_extract       | 提取 json 值                                                             |
|                | column->path       | json_extract 的简洁写法，MySQL 5.7.9 开始支持                            |
|                | json_keys          | 提取 json 中的键值为 json 数组                                           |
|                | json_search        | 按给定字符串关键字搜索 json，返回匹配的路径                              |
| 修改 json      | json_append        | 废弃，MySQL 5.7.9 开始改名为 json_array_append                           |
|                | json_array_append  | 末尾添加数组元素，如果原有值是数值或 json 对象，则转成数组后，再添加元素 |
|                | json_array_insert  | 插入数组元素                                                             |
|                | json_insert        | 插入值（插入新值，但不替换已经存在的旧值）                               |
|                | json_merge         | 合并 json 数组或对象                                                     |
|                | json_remove        | 删除 json 数据                                                           |
|                | json_replace       | 替换值（只替换已经存在的旧值）                                           |
|                | json_set           | 设置值（替换旧值，并插入不存在的新值）                                   |
|                | json_unquote       | 去除 json 字符串的引号，将值转成 string 类型                             |
| 返回 json 属性 | json_depth         | 返回 json 文档的最大深度                                                 |
|                | json_length        | 返回 json 文档的长度                                                     |
|                | json_type          | 返回 json 值得类型                                                       |
|                | json_valid         | 判断是否为合法 json 文档                                                 |
