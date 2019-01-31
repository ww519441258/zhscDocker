FROM centos:7
LABEL version="1.1"
LABEL description="Web development environment."

# install php env
WORKDIR /root/src/
RUN yum install -y wget vim net-tools screen git openssl initscripts
RUN wget http://soft.vpser.net/lnmp/lnmp1.5.tar.gz -cO lnmp1.5.tar.gz && tar zxf lnmp1.5.tar.gz && cd lnmp1.5 && LNMP_Auto="y" DBSelect="9" DB_Root_Password="73937393" InstallInnodb="y" PHPSelect="8" SelectMalloc="1" ./install.sh lnmp

#install Python 2.7
#WORKDIR /root/src/
#RUN wget http://www.python.org/ftp/python/2.7.13/Python-2.7.13.tar.xz && tar xvf Python-2.7.13.tar.xz && cd Python-2.7.13 && ./configure && make && make install && curl https://bootstrap.pypa.io/get-pip.py | python2.7 && pip2 install pyyaml && pip2 install typing


#install shadaosocks
#WORKDIR /root/src
#COPY shadowsocks.json /etc/shadowsocks.json
#RUN curl "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py" && python get-pip.py && pip install --upgrade pip && pip install shadowsocks && nohup sslocal -c /etc/shadowsocks.json /dev/null 2>&1 &

#install MongoDB
#WORKDIR /root/src/
#COPY mongodb-org-4.0.repo /etc/yum.repos.d/mongodb-org-4.0.repo
#RUN yum install -y mongodb-org && mkdir -p /home/data/mongodb/ && chown mongo.mongo /home/data/mongodb/
#COPY mongo /etc/init.d/mongo

# install Imagick
WORKDIR /root/src/
RUN rpm -e --nodeps freetype-2.8-12.el7.x86_64 && rm -rf /usr/include/freetype2 && wget https://download.savannah.gnu.org/releases/freetype/freetype-2.9.tar.gz && tar zxvf  freetype-2.9.tar.gz && cd freetype-2.9 && ./configure && make && make install && cd .. && wget http://file.kcshop.pro/ImageMagick-7.0.7-25.tar.gz && tar zxvf ImageMagick-7.0.7-25.tar.gz && cd ImageMagick-7.0.7-25 && ./configure && make && make install && cd .. && wget http://file.kcshop.pro/imagick-3.4.3.tgz && tar zxvf imagick-3.4.3.tgz && cd imagick-3.4.3 && /usr/local/php/bin/phpize && ./configure --with-php-config=/usr/local/php/bin/php-config && make && make install && sed -i '/\[PHP\]/a\extension=imagick\.so' /usr/local/php/etc/php.ini;

# install Redis
WORKDIR /root/src/
RUN wget http://download.redis.io/releases/redis-5.0.3.tar.gz && tar zxvf redis-5.0.3.tar.gz && cd redis-5.0.3 && make && make install && cp redis.conf /etc/ && sed -i 's/daemonize no/daemonize yes/' /etc/redis.conf
COPY redis /etc/init.d/redis

# setup start
COPY start.sh /root/start.sh
CMD /root/start.sh
