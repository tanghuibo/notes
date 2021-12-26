# vscode 设置

## 快捷键

| 命令                             | 功能 |
| -------------------------------- | ---- |
| workbench.action.navigateForward | 前进 |
| workbench.action.navigateBack    | 后退 |

---

## 设置

| 命令            | 功能     |
| --------------- | -------- |
| editor.wordWrap | 换行显示 |

设置 html 换行

```json
{
    "vetur.format.defaultFormatter.html": "js-beautify-html",
    "vetur.format.defaultFormatterOptions": {
       "js-beautify-html": {
           "wrap_attributes": "auto",
       }
    }
}
```

## 好用的插件

leetCode: 在 vscode 中刷题

Browser Preview: 在 vscode 中显示网页

Auto Rename Tag 自动重命名标签

Path Intellisense `@` 路径提示
