FROM	debian:sid

MAINTAINER	Goldy

ADD	conf/apt-no-recommends /etc/apt/apt.conf.d/apt-no-recommends
RUN	apt-get update
RUN	apt-get -y install nginx mariadb-server php5-fpm php5-mysql php5-json php5-cli git eyed3 faad php5-gd vorbis-tools supervisor ca-certificates php5-curl libav-tools
ADD	conf/nginx_ampache /etc/nginx/sites-available/ampache
ADD	conf/supervisor_app /etc/supervisor/conf.d/apps.conf
RUN	echo "daemon off;" >> /etc/nginx/nginx.conf	
RUN	rm /etc/nginx/sites-enabled/default
RUN	ln -s /etc/nginx/sites-available/ampache /etc/nginx/sites-enabled/
RUN	git clone https://github.com/ampache/ampache.git /var/www/ampache
RUN	chown -R www-data:www-data /var/www/ampache

EXPOSE	80
VOLUME	/media

CMD ["/usr/bin/supervisord"]
