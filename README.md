# tdiary
This is a template for people who want to write personal journals. 
Also, I want to implement the function which we can record our research diaries.

# Update Logs
2018年 3月25日 星期日 12时52分57秒 CST

昨天在编译的时候发现一个小 bug，偶数页的页眉无法显示，导致编译无法通过。

经过排查，最终发现是 `\foreach` 导致了错误，怪我自己没有认真读 `pgfmanual`
文档，`\foreach` 块里面的内容都是局部的，无法作用到全局, 所以是作用域的问题。

最后经过一番 google, 找到了解决方法，使用 `pgfplots` 宏包里面的 `\pgfplotsforeachungrouped`
代替 `\foreach` 就可以了，用法基本一致。

