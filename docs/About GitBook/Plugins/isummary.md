# gitbook-plugin-isummary

自动根据目录创建SUMMARY.md文件，能忽略指定路径。

[Github](https://github.com/freedomljt/gitbook-plugin-isummary)

book.json

```json
{
  "plugins": [
    "isummary"
  ],
  "pluginsConfig": {
    "isummary": {
      "ignorePage": ["assets"]
    }
  }
}
```