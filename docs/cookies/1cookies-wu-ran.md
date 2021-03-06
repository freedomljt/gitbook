# Cookies污染问题

## 业务场景

* cookies key 相同，利于编写代码
* 不同环境使用子域名进行区分，如 a.dev.toobe.com/a.test.toobe.com
* 相同环境下不同系统通过子域名区分且保持状态， 如 a.dev.toobe.com/b.dev.toobe.com
* 生产域名直接使用无环境子域，如 a.toobe.com/b.toobe.com

## 问题

* 直接使用根域，当同一浏览器同时登陆dev和生产时，dev会被生产污染（cookies读取的先后顺序）

## 解决办法

1. 所有环境直接区分，不存在最根域名下的cookie
   * 问题：对于生产域名不友好
2. 直接使用单独域名进行区分【一劳永逸】
   * 问题：-
3. 当登陆a系统，直接设置所有系统域名下的cookies
   * 问题：产生大量cookies，且不利于删除操作
4. 🌟不同环境使用不同key进行cookies标记
   * 问题：可直接通过不同环境构建时直接写死，但是每个系统必须保持一致。
5. 使用path区分
   * 问题：不利于代码编写

