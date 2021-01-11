FROM kuborgh/php-5.2:latest

RUN mv /etc/apt/sources.list /etc/apt/sources.list.bak&&\
    echo "deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ precise main restricted universe multiverse" >> /etc/apt/sources.list&&\
    echo "deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ precise-updates main restricted universe multiverse" >> /etc/apt/sources.list&&\
    echo "deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ precise-backports main restricted universe multiverse" >> /etc/apt/sources.list&&\
    echo "deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ precise-security main restricted universe multiverse" >> /etc/apt/sources.list&&\
    apt-get update && apt-get install -y --no-install-recommends mysql-server &&\
    sed -i 's/project/var\/www\/html/g' /etc/apache2/sites-enabled/000-project.conf&&\
    mkdir -p /var/www/html/ && echo "<?php phpinfo();?>" > /var/www/html/index.php &&\
    echo "nohup /usr/sbin/mysqld&" >> /start.sh&&\
    echo "exec /usr/sbin/apache2ctl -D FOREGROUND" >> /start.sh&&\
    chmod +x /start.sh

EXPOSE 80
CMD ["/bin/sh", "/start.sh"]