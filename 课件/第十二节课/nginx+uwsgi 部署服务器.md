

#nginx+uwsgi django项目部署服务器

购买服务器

vutlr外国的服务器商,

腾讯云, 阿里云 服务商



vutlr上购买服务器 步骤

1. 选择地区

2. 选择系统 ubuntu16.04 x 64

3. 选择配置 最低配就行,

4. Additional Features

5. Startup Script 这个是选

6. ssh keys  ssh链接

7. firewall Group (防火墙)

8. 其他的一些

   



aws上购买服务器

上面有免费的服务器



购买服务器    Linux ubuntu16.04          

#升级环境    apt update 

apt install python3-pip

#安装nginx

apt install nginx

nginx -t

/etc/init.d/nginx stop/ start / restart

#安装虚拟环境

cd  /var/www

pip3 install virtualenv

virtualenv  -p python3 envpro  

source envpro/bin/activate      

pip install -r requirements.txt

#安装虚拟环境uwsgi

apt install python3-dev 

apt install gcc 

pip3 install uwsgi

  

##安装虚拟环境

安装pip3    apt install python3-pip

移动到相关的环境  cd /var/www

安装环境    pip3 install virtualenv          

升级pip    pip3 install --upgrade pip            

创建环境    virtualenv  -p python3 envpro  

入虚拟环境    source envpro/bin/activate       

```python
# 在以前项目环境里导出环境
pip freeze > requirements.txt  
# 在环境里安装相应的模块
pip install -r requirements.txt

# 可以使用xftp软件把requitements.txt 文件放到传到服务器上


或者一个一个安装需要的模块

安装Django    pip3 install django==1.11.6          

安装相应的模块 django-bootstrap4   django-simple-captcha  pymysql
```

   

##安装数据库

安装 Mysql  apt install mysql-server

输入root的密码 

安装mysql   apt install libmysqlclient-dev

``` python
安装成功后可以通过下面的命令测试是否安装成功：netstat -tap | grep mysql

现在设置mysql允许远程访问，首先编辑文件/etc/mysql/mysql.conf.d/mysqld.cnf：

sudo vi /etc/mysql/mysql.conf.d/mysqld.cnf

注释掉bind-address = 127.0.0.1：

保存退出，然后进入mysql，执行授权命令：

创建普通用户

  CREATE USER 'username'@'%' IDENTIFIED BY 'password';
    
给普通用户赋权

grant all on *.* to username@'%' identified by 'password' with grant option;

grant all on *.* to root@'%' identified by 'li123465' with grant option;


flush privileges;

然后执行quit命令退出mysql服务，执行如下命令重启mysql：

service mysql restart
```

## 项目导入或者是项目建立

```python
 第一种
1. 安装Mezzanine    pip install mezzanine
2. 创建mezzanine    mezzanine-project librepath          
3. 移动目录    cd librepath          
4. 创建数据库    python manage.py  createdb          
5. 收集资源    python manage.py  collectstatic          
6. 修改设置    Vim librepath/settings.py          ALLOWDE_HOSTS    =[“服务器ip”]         
7. 测试    python manage.py runserver   
```

```python
 第二种
1.查看有没有git  git --version    没有就安装   apt install git
2.文件夹放项目   /var/www  这个文件夹下面
2.克隆自己的项目  git clone https://github.com/pizil-li/blog
3.修改设置    Vim blog/settings.py          ALLOWDE_HOSTS =[“服务器ip”] 
4.配置数据库
5.makemigrations and migrate and createsuperuser
6.python manage.py runserver 0:8000
7.浏览器打开ip:8000
```



## 安装uwsgi 需要安装两个   虚拟环境和本地环境

安装需要依赖的包  

apt install python3-dev 

apt install gcc

安装uwsgi    pip3 install uwsgi       还是在虚拟环境里面

测试uwsgi    uwsgi --http :8000 --module 项目.wsgi         

如 : uwsgi --http :8000 --module blog.wsgi         

真实环境中安装uwsgi

测试    uwsgi --ini uwsgi.ini    



```
如果端口被占用

查看端口号  lsof -i   

关闭端口  kill 端口号   

移动目录    cd  /var/www/tanzhou   

```

 

nginx.conf  uwsgi.ini  uwsgi_params     下面有具体的写法      

配置 socket  配置conf文件 和 ini文件          

在/etc/nginx/sites-enabled文件夹下面删除default之后`新建`一个blog_nginx.conf

```python
#the upstream component nginx needs to connect to
upstream django {
    # server unix:///path/to/your/mysite/mysite.sock; # for a file socket
    server   127.0.0.1:8001; # for a web port socket (we'll use this first)
}

# configuration of the server
server {
    # the port your site will be served on
    listen      80;
    # the domain name it will serve for
    server_name  144.202.120.211; # substitute your machine's IP address or FQDN
    charset     utf-8;

    # max upload size
    client_max_body_size 75M;   # adjust to taste

    # Django media
    location /media  {
        alias  /var/www/blog2/media;  # your Django project's media files - amend as required
    }

    location /static {
        alias /var/www/blog2/static; # your Django project's static files - amend as required
    }

    # Finally, send all non-media requests to the Django server.
    location / {
        uwsgi_pass  django;
        include     /var/www/uwsgi_params; # the uwsgi_params file you installed
    }
}

```

在 /var/www/ 文件夹下建立两个文件..  uwsgi.ini  和   uwsgi_params

uwsgi.ini

```python
[uwsgi]
# Django-related settings
# the base directory (full path)
chdir           = /var/www/blog2
# Django's wsgi file
module          =  blog2.wsgi
# the virtualenv (full path)
home            = /var/www/envpro

# process-related settings
# master
master          = true
# maximum number of worker processes
processes       = 10
# the socket (use the full path to be safe
socket         = :8001
# ... with appropriate permissions - may be needed
chmod-socket    = 664
# clear environment on exit
vacuum          = true

```

uwsgi_params

```
uwsgi_param  QUERY_STRING       $query_string;
uwsgi_param  REQUEST_METHOD     $request_method;
uwsgi_param  CONTENT_TYPE       $content_type;
uwsgi_param  CONTENT_LENGTH     $content_length;
	
uwsgi_param  REQUEST_URI        $request_uri;
uwsgi_param  PATH_INFO          $document_uri;
uwsgi_param  DOCUMENT_ROOT      $document_root;
uwsgi_param  SERVER_PROTOCOL    $server_protocol;
uwsgi_param  REQUSET_SCHEME     $scheme;
uwsgi_param  HTTPS              $https if_not_empty;
	
uwsgi_param  REMOTE_ADDR        $remote_addr;
uwsgi_param  REMOTE_PORT        $remote_port;
uwsgi_param  SERVER_PORT        $server_port;
uwsgi_param  SERVER_NAME        $server_name;

```



自动启动 uwsgi 文件

vim /etc/rc.local

在exit 0 前加一行

/usr/local/bin/uwsgi --ini /var/www/uwsgi.ini

然后reboot



查找某个应用的位置 

如: which uwsgi



参考：



官方文档:  https://uwsgi-docs.readthedocs.io/en/latest/tutorials/Django_and_nginx.html



bilibili上讲接nginx的视频  

1. https://www.bilibili.com/video/av10247256?from=search&seid=9655370704651196700
2. https://www.bilibili.com/video/av10244432?from=search&seid=9655370704651196700



安装文件的时候使用豆瓣源

<https://pypi.doubanio.com/simple/pip> 



如:  install xxx -i [http://pypi.douban.com/simple/](https://www.douban.com/link2/?url=http%3A%2F%2Fpypi.douban.com%2Fsimple%2F)   







```
apt update 

apt install python3-pip

apt install nginx

nginx -t

/etc/init.d/nginx stop/ start

pip3 install virtualenv

virtualenv  -p python3 envpro  

source envpro/bin/activate      

pip install -r requirements.txt

/etc/init.d/nginx restart

apt install python3-dev 

apt install gcc 

pip3 install uwsgi

ln -s etc/nginx/blog_nginx.conf /etc/nginx/sites-enabled/blog_nginx.conf

```

