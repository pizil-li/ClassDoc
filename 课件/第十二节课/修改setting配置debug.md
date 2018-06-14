# 修改setting配置debug

1. 修改 host['IP'] 

2. 根据计算机名修改debug

3. DEBUG开启会使用更多的资源。  

4. 任何404,500等错误都会返回特殊页面，暴露特殊信息。  

5. 异常和脚本错误都会显示具体源码，必须隐藏。 

6. 我们需要根据hostname来关闭/开启DEBUG/TEMPLATE_DEBUG模式

   ```python
   # 根据是不是本地计算机的名字   修改主机名 在超级用户下  hostname 修改名 passwd 修改密码
   import socket
   if socket.gethostname() == 'Vip':
       DEBUG = TEMPLATE_DEBUG = True
       DATABASE_NAME = 'blogdb'
   else:
       DEBUG = TEMPLATE_DEBUG = False
       DATABASE_NAME = 'production_db'
   ```

   

   ```python
   # 需要在setting 里面把相关的邮箱发送配置好 
   
   
   # QQ 邮箱发送
   EMAIL_HOST = "smtp.qq.com"
   EMAIL_PORT = 465  # SSL  # 第三种配置方式
   # EMAIL_PORT = 587  #  TSL  # 第二种配置方式
   # EMAIL_PORT = 25   #第一种配置方式
   EMAIL_HOST_USER = "3003002865@qq.com"
   EMAIL_HOST_PASSWORD = "xtyxxnyonltqdfgf"
   # EMAIL_USE_TLS = True  #第一种配置方式 # 第二种配置方式
   EMAIL_USE_SSL = True   #第三种配置方式
   EMAIL_FROM = "3003002865@qq.com"
   
   
   ADMINS = (
   ('shan','3003002865@qq.com'),
   )
   
   # 我们需要定义一个管理者邮箱，来接收用户访问未命中的报告（指404访问错误。）
   # 当DEBUG=FALSE 而且在MIDDLEWARE_CLASS中增加了下面的行时候，邮件才会发送：
   # 需要配置一个中间件
   MIDDLEWARE_CLASSES=(
     .....
    'django.middleware.common.BrokenLinkEmailsMiddleware',
   )
   
   MANAGERS = (
   ('shan', '3003002865@qq.com'),
   )
   
   
   ```

   配置404 500 错误页面

   ```python
   # 在url.py 文件下面最后加上
   
   handler404 = 'paper.views.page_not_found'
   handler500 = 'paper.views.page_error'
   
   # 在 user.views.py 文件加上两个函数
   
   def page_not_found(request):
       #全局404处理函数
       from django.shortcuts import render_to_response
       response = render_to_response('404.html', {})
       response.status_code = 404
       return response
   
   def page_error(request):
       #全局500处理函数
       from django.shortcuts import render_to_response
       response = render_to_response('500.html', {})
       response.status_code = 500
       return response
   
   # 在template文件里面把404.html和500html文件放进去
   # 在dubug为false的时候才会调用这些函数
   ```

   

7. 多服务器分离.

8. 安全

9. 管理 supervisor