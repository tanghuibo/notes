# GITBOOK使用教程

## 简介

GitBook 是一个基于 Node.js 的命令行工具，可使用 Github/Git 和 Markdown 来制作精美的电子书，GitBook 并非关于 Git 的教程。

## 安装

需要提前安装[nodejs](http://nodejs.cn/download/)

安装gitbook

```bash
npm i -g gitbook-cli
或
yarn global add gitbook-cli 
```

## 使用

### 创建一个文件夹 & 进入文件

运行 `gitbook init` 进行初始化

初始化完成后运行 `gitbook serve` 启动服务器

浏览器打开[http://127.0.0.1:4000](http://127.0.0.1:4000) 进行查看

## 打包

运行 `gitbook build` 进行打包， 打包生产 `_book`目录

## 目录

修改文件 `SUMMARY.md`

支持两种目录配置方法:

```markdown
# Summary
* [前言](README.md)

### PART 1
* [PART1.1](PART1/1.md)
* [PART1.2](PART1/2.md)
```

```markdown
# Summary
* [前言](README.md)

* [PART1](PART1.md)
    * [PART1.1](PART1/1.md)
    * [PART1.2](PART1/2.md)
```

## 插件安装 & 配置

创建 `book.json` 进行个性话配置

```json
{
    "plugins": [
        "github"
    ],
    "pluginsConfig": {
        "github": {
            "url": "https://github.com/tanghuibo"
        }
    }
}
```

修改完成后运行 `gitbook install` 安装插件，重启后完成安装

## 将GITBOOK发布到GITHUB

1. 在github工程上新建分支`gh-pages`

2. 讲_book底下的文件提交到`gh-pages`分之

以该工程为例，该工程的代码托管在[https://github.com/tanghuibo/notes/tree/master](https://github.com/tanghuibo/notes/tree/master)

生成的_book文件托管在[https://github.com/tanghuibo/notes/tree/gh-pages](https://github.com/tanghuibo/notes/tree/gh-pages)

于是便可以通过[https://tanghuibo.github.io/notes/](https://tanghuibo.github.io/notes/)展示gitbook
