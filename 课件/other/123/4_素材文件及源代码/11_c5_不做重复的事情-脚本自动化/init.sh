#!/bin/bash
cd `dirname $0`
if [ $# != 4 ];then
    echo "USAGE:./$(basename $0) <DB_NAME> <DB_USR> <DB_PASSWD> <ROOT_PASSWD>"
    echo $'\twhere <DB_NAME> is the database name you want to create for the webserver,'
    echo $'\t<DB_USR> is the user specified for the new created database'
    echo $'\t<ROOT_PASSWD> is the password for root(mysql has empty password by default)'
    echo $'\t'."e.g. $(basename $0) blog_prj_db shawn 123456 654321"
    exit 0
fi

if [ -e "initDB.sql.bak" ];then
cp -f initDB.sql.bak initDB.sql
elif [ -e "initDB.sql" ];then
cp initDB.sql initDB.sql.bak
else
echo "ERROR:initDB.sql not found!"
exit 1
fi

sed -i "s/<DB_NAME>/${1}/g" initDB.sql
sed -i "s/<DB_USR>/${2}/g" initDB.sql
sed -i "s/<DB_PASSWD>/${3}/g" initDB.sql
sed -i "s/<ROOT_PASSWD>/${4}/g" initDB.sql


yum install zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel python-devel mysql-devel libjpeg-devel gcc make -y
if [ $? != 0 ];then
echo  "Dependencies installed FAILED! "
exit 1
else
echo "Dependencies installed SUCCESSFULLY. "
fi


if [ -e "Python-3.4.3.tgz" ];then
echo "Python-3.4.3.tgz already exists, skip downloading…"
else
wget https://www.python.org/ftp/python/3.4.3/Python-3.4.3.tgz
fi
if [ -d "Python-3.4.3" ];then
rm –rf Python-3.4.3
fi

if [ ! -e "Python-3.4.3.tgz" ];then
echo "ERROR:Python-3.4.3.tgz not exist!"
exit 1
fi

tar zxvf Python-3.4.3.tgz
if [ $? != 0 ];then
echo "Python-3.4.3.tgz extract FAILED! "
exit 1
else
echo "Python-3.4.3.tgz extract SUCCESSFULLY. "
fi

cd Python-3.4.3
./configure --enable-shared 
make
make install
if [ $? != 0 ];then
echo "Python make/installed FAILED! "
exit 1
else
echo "Python make/installed SUCCESSFULLY. "
fi

cd ..
echo "/usr/local/lib"|tee -a /etc/ld.so.conf
/sbin/ldconfig -v
/usr/local/bin/pip3.4 install --upgrade pip

curr=/usr/bin/python
if [ ! -e "${curr}.bak" ];then
mv $curr ${curr}.bak
fi

py34=/usr/local/bin/python3.4
ln $py34 $curr


#update yum file
ym="/usr/bin/yum"
sed -i 's/\/usr\/bin\/python/\/usr\/bin\/python.bak/' ${ym}

if [ -e "/usr/share/PackageKit/helpers/yum/yumBackend.py" ];then
    sed -i 's/\/usr\/bin\/python/\/usr\/bin\/python.bak/' /usr/share/PackageKit/helpers/yum/yumBackend.py
fi


yum install mysql-server -y

if [ $? != 0 ];then
echo "ERROR: install mysql-server! "
exit 1
fi

chkconfig mysqld on
service mysqld start
mysql -u root < "initDB.sql"
rm -f initDB.sql
mv initDB.sql.bak initDB.sql

#[SEC 3]install mysqlclient&django
/usr/local/bin/pip install mysqlclient

if [ $? != 0 ];then
echo "ERROR: install mysqlclient! "
exit 1
fi

/usr/local/bin/pip install django
if [ $? != 0 ];then
echo "ERROR: install django! "
exit 1
fi

/usr/local/bin/pip install Pillow
if [ $? != 0 ];then
echo "ERROR: install Pillow! "
exit 1
fi

#[SEC 4]configure iptables
/sbin/iptables -I INPUT -p tcp --dport 80 -j ACCEPT
service iptables save
if [ $? != 0 ];then
echo "ERROR: iptables! "
else
echo "FINISHED SUCCESSFULLY. "
fi


cd blog_project
python manage.py migrate
python manage.py runserver 0.0.0.0:80
