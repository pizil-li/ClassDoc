## django+bootstrap博客建立

###上节课回顾

关于user的权限问题,和user升级权限可以登录到后台, 在超级用户的权限在可以创建一些组,来对user进行权限管理

###本节内容

关于一些比较好的网页的建立网站

wordpress  ?  PHP  迁移比较难弄.

wix, https://www.wix.com/ 可以有免费的使用, 可以在创建之后可以有网站给使用,

起飞  http://www.qifeiye.com/   类似于  

squarespace   https://www.squarespace.com/

bootstrap  https://bootstrapmade.com/  前端模板

bootstrap前端模板  + Django后端的建立

1. 在bootstrap的免费模板里面下载自己需要的文件
2. 新进一个django项目,可以根据下载模板的类型,来命名
3. 下载bootstrap的文件之间, 根据网页的类型建立相应的model
4. 把相关的jss cs image 文件都移到相关的文件夹下面
5. 把前端页面的静态文件配置好,主要是路径的问题.
6. 如果有字体的问题,需要修改相关字体的位置的配置.
7. 在setting.py文件里面修改相关的配置
   1. ip ["*"]
   2. staticfile的位置    #  STATICFILES_DIRS = [    os.path.join(BASE_DIR, 'static')]
   3. 数据库的配置  是不是mysql,或者其他的数据库
   4. 可以配置一下语音和时区
8. 设计相关的model和创建新用户
9. 迁移数据库
10. 配置url的地址
11. 配置view的逻辑
12. 去后台添加相关的数据
13. 在前端看看所要的要求和效果


如果想要自己的blog更加好看, 可以考虑使用富文本,或者MarkDown



富文本的使用情况,ckeditor ,MarkDown.
