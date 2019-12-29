# mac os 开启 80 端口

## 1. 添加映射规则

修改 /etc/pf.conf，添加如下代码

```bash
rdr on lo0 inet proto tcp from any to 127.0.0.1 port 80 -> 127.0.0.1 port 8080
```

## 2. 运行命令

```bash
sudo pfctl -d
sudo pfctl -f /etc/pf.conf
sudo pfctl -e
```
