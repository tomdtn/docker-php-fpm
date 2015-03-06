FROM centos

COPY oracle.tar.gz /usr/lib/
COPY remi.repo /etc/yum.repos.d/remi.repo

COPY entrypoint.sh /

RUN LD_LIBRARY_PATH=/usr/lib/oracle/12.1/client64/lib yum install -y --enablerepo=remi-php55,remi php-fpm httpd mod_fcgid php-oci8 php-gd php-bcmath php-soap php-intl php-pecl-mongo php-pdo libaio tar php-opcache php-mbstring php-mcrypt php-mysqlnd --skip-broken
RUN cd /usr/lib && tar xzvf oracle.tar.gz && rm oracle.tar.gz && echo 'export LD_LIBRARY_PATH=/usr/lib/oracle/12.1/client64/lib' > /etc/profile.d/oracle.sh
COPY ./etc /etc

EXPOSE 80
ENTRYPOINT "/bin/sh /entrypoint.sh"
