##nginx+uwsgi 部署服务器

购买服务器    Linux ubuntu16.04          

升级环境安装pip3    apt update\apt-get install python3-pip          

安装nginx   apt install nginx         

测试nginx     /etc/init.d/nginxstart(stop)          

安装环境    pip3 install virtualenv          

升级环境    pip3 install
--upgrade pip          

移动目录    cd /var/www         

创建环境    virtualenv  envpro  

入虚拟环境    source envpro/bin/activate          

安装Django    pip3 install django==1.11.6          

安装Mezzanine    pip install mezzanine
创建mezzanine    mezzanine-project librepath          

移动目录    cd librepath          

创建数据库    python manage.py  createdb          

收集资源    python manage.py  collectstatic          

修改设置    Vim librepath/settings.py          ALLOWDE_HOSTS    =[“服务器ip”]          

测试    python manage.py runserver          

安装uwsgi    pip3 install uwsgi          

移动目录    cd  /var/www/librepath          

测试uwsgi    uwsgi –http :8000 –mdoule librepath.wsgi          

在上一层环境中上传三个文件，nginx.conf uwsgi.ini uwsgi_params             

配置 socket             配置conf和ini             真实环境中安装uwsgi
            测试    uwsgi –ini uwsgi.ini          

把nginx文件配置    cd  /etc/nginx/sites-enabled          

删除默认文件    rm default          

创建软链接    ln -s /var/www/nginx.conf liberpath          

重启nginx    /ect/init.d/nginx restart          

启动uwsgi    uwsgi –ini uwsgi.ini          

设置自动启动    vim  /ect/rc.local          /usr/local/bin/uwsgi --ini  /var/www/uwsgi.ini                

reboot                   

参考 bilibili上讲接nginx的视频豆瓣源

<https://pypi.doubanio.com/simple/pip> 

install xxx -i [http://pypi.douban.com/simple/](https://www.douban.com/link2/?url=http%3A%2F%2Fpypi.douban.com%2Fsimple%2F)   