# postman转换CURL

## CURL

cURL是一个利用URL语法在命令行下工作的文件传输工具，1997年首次发行。它支持文件上传和下载，所以是综合传输工具，但按传统，习惯称cURL为下载工具。cURL还包含了用于程序开发的libcurl。

cURL支持的通信协议有FTP、FTPS、HTTP、HTTPS、TFTP、SFTP、Gopher、SCP、Telnet、DICT、FILE、LDAP、LDAPS、IMAP、POP3、SMTP和RTSP。

curl还支持SSL认证、HTTP POST、HTTP PUT、FTP上传, HTTP form based upload、proxies、HTTP/2、cookies、用户名+密码认证(Basic, Plain, Digest, CRAM-MD5, NTLM, Negotiate and Kerberos)、file transfer resume、proxy tunneling。

### 事例

```bash
curl 'http://fanyi.youdao.com/translate?&doctype=json&type=AUTO&i=hello' -H 'Connection: keep-alive' -H 'Accept-Language: zh-CN,zh;q=0.9' --compressed
```

## postman

### 安装postman

全平台下载地址: [postman下载地址](https://www.getpostman.com/downloads/)

### 导入CURL

`import` -> `paste raw text` -> 粘贴curl代码 -> `import`

![导入curl到postman](../screenshots/工具箱/postman转换curl/导入curl.gif)

### 获取代码

`code` -> 选择语言

![导入curl到postman](../screenshots/工具箱/postman转换curl/获取代码.gif)
