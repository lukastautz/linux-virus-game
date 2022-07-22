#!/bin/bash
# Linux-Virus-Game <https://github.com/lukastautz/linux-virus-game>
# Copyright (C) 2022 Lukas Tautz
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.
#
# You can use Linux-Virus-Game for free in your projects, you can also modify the Linux-Virus-Game files BUT YOU ARE NOT ALLOWED TO DELETE THIS COMMENT!
sudo apt update -y
sudo apt upgrade -y
sudo apt install -y curl gnupg2 ca-certificates lsb-release nginx-core libnginx-mod-http-headers-more-filter ufw apt-transport-https software-properties-common
sudo systemctl enable nginx
sudo ufw allow 22
sudo ufw allow 80
sudo ufw allow 443
sudo ufw --force enable
echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/sury-php.list
wget -qO - https://packages.sury.org/php/apt.gpg | sudo apt-key add -
sudo apt update -y
sudo apt upgrade -y
sudo apt install -y php8.1 php8.1-common php8.1-dev php8.1-fpm
sudo rm -r /etc/php/8.1/apache2
sudo rm -r /etc/php/8.1/cli
sudo rm -r /var/www/html
sudo rm -r /etc/apache2
sudo chmod -R -v 777 /var
sudo chmod -R -v 777 /etc/php
sudo chmod -R -v 777 /etc/nginx
sudo rm /etc/nginx/sites-available/default
sudo echo "server {" >> /etc/nginx/sites-available/default
sudo echo "    listen 80;" >> /etc/nginx/sites-available/default
sudo echo "    listen [::]:80 ipv6only=on;" >> /etc/nginx/sites-available/default
sudo echo "    server_tokens off;" >> /etc/nginx/sites-available/default
sudo echo "    more_set_headers 'Server: virusGame/nginx';" >> /etc/nginx/sites-available/default
sudo echo "    more_clear_headers 'X-Powered-By';" >> /etc/nginx/sites-available/default
sudo echo "    root /var/www/virus-game;" >> /etc/nginx/sites-available/default
sudo echo "    index index.html index.htm index.php index.txt;" >> /etc/nginx/sites-available/default
sudo echo "    server_name $(hostname -I | sed 's/ *$//g');" >> /etc/nginx/sites-available/default
sudo echo "    client_max_body_size 1024M;" >> /etc/nginx/sites-available/default
sudo echo "    location / {" >> /etc/nginx/sites-available/default
sudo echo "        error_page 404 http://\$server_name;" >> /etc/nginx/sites-available/default
sudo echo "        try_files \$uri \$uri/ =404;" >> /etc/nginx/sites-available/default
sudo echo "    }" >> /etc/nginx/sites-available/default
sudo echo "    location ~ .php$ {" >> /etc/nginx/sites-available/default
sudo echo "        include snippets/fastcgi-php.conf;" >> /etc/nginx/sites-available/default
sudo echo "        fastcgi_pass unix:/var/run/php/php8.1-fpm.sock;" >> /etc/nginx/sites-available/default
sudo echo "    }" >> /etc/nginx/sites-available/default
sudo echo "    location ~ .vgame$ {" >> /etc/nginx/sites-available/default
sudo echo "        deny all;" >> /etc/nginx/sites-available/default
sudo echo "    }" >> /etc/nginx/sites-available/default
sudo echo "}" >> /etc/nginx/sites-available/default
sudo echo "server {" >> /etc/nginx/sites-available/default
sudo echo "    listen 443;" >> /etc/nginx/sites-available/default
sudo echo "    listen [::]:443;" >> /etc/nginx/sites-available/default
sudo echo "    server_tokens off;" >> /etc/nginx/sites-available/default
sudo echo "    more_set_headers 'Server: virusGame/nginx';" >> /etc/nginx/sites-available/default
sudo echo "    server_name $(hostname -I | sed 's/ *$//g');" >> /etc/nginx/sites-available/default
sudo echo "    return 302 http://\$server_name;" >> /etc/nginx/sites-available/default
sudo echo "}" >> /etc/nginx/sites-available/default
sudo rm /etc/nginx/nginx.conf
sudo echo 'user root;' >> /etc/nginx/nginx.conf
sudo echo 'worker_processes auto;' >> /etc/nginx/nginx.conf
sudo echo 'pid /run/nginx.pid;' >> /etc/nginx/nginx.conf
sudo echo 'include /etc/nginx/modules-enabled/*.conf;' >> /etc/nginx/nginx.conf
sudo echo 'events {' >> /etc/nginx/nginx.conf
sudo echo '    worker_connections 512;' >> /etc/nginx/nginx.conf
sudo echo '}' >> /etc/nginx/nginx.conf
sudo echo 'http {' >> /etc/nginx/nginx.conf
sudo echo '    sendfile on;' >> /etc/nginx/nginx.conf
sudo echo '    tcp_nopush on;' >> /etc/nginx/nginx.conf
sudo echo '    types_hash_max_size 2048;' >> /etc/nginx/nginx.conf
sudo echo '    server_tokens off;' >> /etc/nginx/nginx.conf
sudo echo '    include /etc/nginx/mime.types;' >> /etc/nginx/nginx.conf
sudo echo '    default_type application/octet-stream;' >> /etc/nginx/nginx.conf
sudo echo '    ssl_protocols TLSv1 TLSv1.1 TLSv1.2 TLSv1.3;' >> /etc/nginx/nginx.conf
sudo echo '    ssl_prefer_server_ciphers on;' >> /etc/nginx/nginx.conf
sudo echo '    access_log /dev/null;' >> /etc/nginx/nginx.conf
sudo echo '    error_log /dev/null;' >> /etc/nginx/nginx.conf
sudo echo '    gzip on;' >> /etc/nginx/nginx.conf
sudo echo '    include /etc/nginx/conf.d/*.conf;' >> /etc/nginx/nginx.conf
sudo echo '    include /etc/nginx/sites-enabled/*;' >> /etc/nginx/nginx.conf
sudo echo '}' >> /etc/nginx/nginx.conf
sudo mkdir /var/www/virus-game
sudo chmod -R -v 777 /var
sudo rm /etc/php/8.1/fpm/php.ini
sudo echo '[PHP]' >> /etc/php/8.1/fpm/php.ini
sudo echo 'engine = On' >> /etc/php/8.1/fpm/php.ini
sudo echo 'short_open_tag = Off' >> /etc/php/8.1/fpm/php.ini
sudo echo 'precision = 14' >> /etc/php/8.1/fpm/php.ini
sudo echo 'output_buffering = On' >> /etc/php/8.1/fpm/php.ini
sudo echo 'zlib.output_compression = Off' >> /etc/php/8.1/fpm/php.ini
sudo echo 'implicit_flush = Off' >> /etc/php/8.1/fpm/php.ini
sudo echo 'unserialize_callback_func =' >> /etc/php/8.1/fpm/php.ini
sudo echo 'serialize_precision = -1' >> /etc/php/8.1/fpm/php.ini
sudo echo 'disable_functions =' >> /etc/php/8.1/fpm/php.ini
sudo echo 'disable_classes =' >> /etc/php/8.1/fpm/php.ini
sudo echo 'zend.enable_gc = On' >> /etc/php/8.1/fpm/php.ini
sudo echo 'zend.exception_ignore_args = Off' >> /etc/php/8.1/fpm/php.ini
sudo echo 'zend.exception_string_param_max_len = 15' >> /etc/php/8.1/fpm/php.ini
sudo echo 'expose_php = On' >> /etc/php/8.1/fpm/php.ini
sudo echo 'max_execution_time = 60' >> /etc/php/8.1/fpm/php.ini
sudo echo 'max_input_time = 60' >> /etc/php/8.1/fpm/php.ini
sudo echo 'memory_limit = 256M' >> /etc/php/8.1/fpm/php.ini
sudo echo 'error_reporting = E_ALL' >> /etc/php/8.1/fpm/php.ini
sudo echo 'display_errors = Off' >> /etc/php/8.1/fpm/php.ini
sudo echo 'display_startup_errors = On' >> /etc/php/8.1/fpm/php.ini
sudo echo 'log_errors = Off' >> /etc/php/8.1/fpm/php.ini
sudo echo 'ignore_repeated_errors = Off' >> /etc/php/8.1/fpm/php.ini
sudo echo 'ignore_repeated_source = Off' >> /etc/php/8.1/fpm/php.ini
sudo echo 'report_memleaks = On' >> /etc/php/8.1/fpm/php.ini
sudo echo 'variables_order = "GPCS"' >> /etc/php/8.1/fpm/php.ini
sudo echo 'request_order = "GP"' >> /etc/php/8.1/fpm/php.ini
sudo echo 'register_argc_argv = Off' >> /etc/php/8.1/fpm/php.ini
sudo echo 'auto_globals_jit = On' >> /etc/php/8.1/fpm/php.ini
sudo echo 'post_max_size = 1024M' >> /etc/php/8.1/fpm/php.ini
sudo echo 'auto_prepend_file =' >> /etc/php/8.1/fpm/php.ini
sudo echo 'auto_append_file =' >> /etc/php/8.1/fpm/php.ini
sudo echo 'default_mimetype = "text/html"' >> /etc/php/8.1/fpm/php.ini
sudo echo 'default_charset = "UTF-8"' >> /etc/php/8.1/fpm/php.ini
sudo echo 'doc_root =' >> /etc/php/8.1/fpm/php.ini
sudo echo 'user_dir =' >> /etc/php/8.1/fpm/php.ini
sudo echo 'enable_dl = Off' >> /etc/php/8.1/fpm/php.ini
sudo echo 'file_uploads = On' >> /etc/php/8.1/fpm/php.ini
sudo echo 'upload_max_filesize = 512M' >> /etc/php/8.1/fpm/php.ini
sudo echo 'max_file_uploads = 100' >> /etc/php/8.1/fpm/php.ini
sudo echo 'allow_url_fopen = On' >> /etc/php/8.1/fpm/php.ini
sudo echo 'allow_url_include = Off' >> /etc/php/8.1/fpm/php.ini
sudo echo 'default_socket_timeout = 60' >> /etc/php/8.1/fpm/php.ini
sudo echo 'extension=bz2' >> /etc/php/8.1/fpm/php.ini
sudo echo 'extension=curl' >> /etc/php/8.1/fpm/php.ini
sudo echo 'extension=ffi' >> /etc/php/8.1/fpm/php.ini
sudo echo 'extension=ftp' >> /etc/php/8.1/fpm/php.ini
sudo echo 'extension=fileinfo' >> /etc/php/8.1/fpm/php.ini
sudo echo 'extension=gd' >> /etc/php/8.1/fpm/php.ini
sudo echo 'extension=exif' >> /etc/php/8.1/fpm/php.ini
sudo echo 'extension=openssl' >> /etc/php/8.1/fpm/php.ini
sudo echo '[CLI Server]' >> /etc/php/8.1/fpm/php.ini
sudo echo 'cli_server.color = On' >> /etc/php/8.1/fpm/php.ini
sudo echo '[Date]' >> /etc/php/8.1/fpm/php.ini
sudo echo '[filter]' >> /etc/php/8.1/fpm/php.ini
sudo echo '[iconv]' >> /etc/php/8.1/fpm/php.ini
sudo echo '[imap]' >> /etc/php/8.1/fpm/php.ini
sudo echo '[intl]' >> /etc/php/8.1/fpm/php.ini
sudo echo '[sqlite3]' >> /etc/php/8.1/fpm/php.ini
sudo echo '[Pcre]' >> /etc/php/8.1/fpm/php.ini
sudo echo '[Pdo]' >> /etc/php/8.1/fpm/php.ini
sudo echo '[Pdo_mysql]' >> /etc/php/8.1/fpm/php.ini
sudo echo 'pdo_mysql.default_socket=' >> /etc/php/8.1/fpm/php.ini
sudo echo '[Phar]' >> /etc/php/8.1/fpm/php.ini
sudo echo '[mail function]' >> /etc/php/8.1/fpm/php.ini
sudo echo 'SMTP = localhost' >> /etc/php/8.1/fpm/php.ini
sudo echo 'smtp_port = 25' >> /etc/php/8.1/fpm/php.ini
sudo echo 'mail.add_x_header = Off' >> /etc/php/8.1/fpm/php.ini
sudo echo '[ODBC]' >> /etc/php/8.1/fpm/php.ini
sudo echo 'odbc.allow_persistent = On' >> /etc/php/8.1/fpm/php.ini
sudo echo 'odbc.check_persistent = On' >> /etc/php/8.1/fpm/php.ini
sudo echo 'odbc.max_persistent = -1' >> /etc/php/8.1/fpm/php.ini
sudo echo 'odbc.max_links = -1' >> /etc/php/8.1/fpm/php.ini
sudo echo 'odbc.defaultlrl = 4096' >> /etc/php/8.1/fpm/php.ini
sudo echo 'odbc.defaultbinmode = 1' >> /etc/php/8.1/fpm/php.ini
sudo echo '[MySQLi]' >> /etc/php/8.1/fpm/php.ini
sudo echo 'mysqli.max_persistent = -1' >> /etc/php/8.1/fpm/php.ini
sudo echo 'mysqli.allow_persistent = On' >> /etc/php/8.1/fpm/php.ini
sudo echo 'mysqli.max_links = -1' >> /etc/php/8.1/fpm/php.ini
sudo echo 'mysqli.default_port = 3306' >> /etc/php/8.1/fpm/php.ini
sudo echo 'mysqli.default_socket =' >> /etc/php/8.1/fpm/php.ini
sudo echo 'mysqli.default_host =' >> /etc/php/8.1/fpm/php.ini
sudo echo 'mysqli.default_user =' >> /etc/php/8.1/fpm/php.ini
sudo echo 'mysqli.default_pw =' >> /etc/php/8.1/fpm/php.ini
sudo echo 'mysqli.reconnect = Off' >> /etc/php/8.1/fpm/php.ini
sudo echo '[mysqlnd]' >> /etc/php/8.1/fpm/php.ini
sudo echo 'mysqlnd.collect_statistics = On' >> /etc/php/8.1/fpm/php.ini
sudo echo 'mysqlnd.collect_memory_statistics = On' >> /etc/php/8.1/fpm/php.ini
sudo echo '[OCI8]' >> /etc/php/8.1/fpm/php.ini
sudo echo '[PostgreSQL]' >> /etc/php/8.1/fpm/php.ini
sudo echo 'pgsql.allow_persistent = On' >> /etc/php/8.1/fpm/php.ini
sudo echo 'pgsql.auto_reset_persistent = Off' >> /etc/php/8.1/fpm/php.ini
sudo echo 'pgsql.max_persistent = -1' >> /etc/php/8.1/fpm/php.ini
sudo echo 'pgsql.max_links = -1' >> /etc/php/8.1/fpm/php.ini
sudo echo 'pgsql.ignore_notice = 0' >> /etc/php/8.1/fpm/php.ini
sudo echo 'pgsql.log_notice = 0' >> /etc/php/8.1/fpm/php.ini
sudo echo '[bcmath]' >> /etc/php/8.1/fpm/php.ini
sudo echo 'bcmath.scale = 0' >> /etc/php/8.1/fpm/php.ini
sudo echo '[browscap]' >> /etc/php/8.1/fpm/php.ini
sudo echo '[Session]' >> /etc/php/8.1/fpm/php.ini
sudo echo 'session.save_handler = files' >> /etc/php/8.1/fpm/php.ini
sudo echo 'session.use_strict_mode = 0' >> /etc/php/8.1/fpm/php.ini
sudo echo 'session.use_cookies = 1' >> /etc/php/8.1/fpm/php.ini
sudo echo 'session.use_only_cookies = 1' >> /etc/php/8.1/fpm/php.ini
sudo echo 'session.name = PHPSESSID' >> /etc/php/8.1/fpm/php.ini
sudo echo 'session.auto_start = 0' >> /etc/php/8.1/fpm/php.ini
sudo echo 'session.cookie_lifetime = 0' >> /etc/php/8.1/fpm/php.ini
sudo echo 'session.cookie_path = /' >> /etc/php/8.1/fpm/php.ini
sudo echo 'session.cookie_domain =' >> /etc/php/8.1/fpm/php.ini
sudo echo 'session.cookie_httponly =' >> /etc/php/8.1/fpm/php.ini
sudo echo 'session.cookie_samesite =' >> /etc/php/8.1/fpm/php.ini
sudo echo 'session.serialize_handler = php' >> /etc/php/8.1/fpm/php.ini
sudo echo 'session.gc_probability = 1' >> /etc/php/8.1/fpm/php.ini
sudo echo 'session.gc_divisor = 1000' >> /etc/php/8.1/fpm/php.ini
sudo echo 'session.gc_maxlifetime = 2678400' >> /etc/php/8.1/fpm/php.ini
sudo echo 'session.referer_check =' >> /etc/php/8.1/fpm/php.ini
sudo echo 'session.cache_limiter = nocache' >> /etc/php/8.1/fpm/php.ini
sudo echo 'session.cache_expire = 180' >> /etc/php/8.1/fpm/php.ini
sudo echo 'session.use_trans_sid = 0' >> /etc/php/8.1/fpm/php.ini
sudo echo 'session.sid_length = 26' >> /etc/php/8.1/fpm/php.ini
sudo echo 'session.trans_sid_tags = "a=href,area=href,frame=src,form="' >> /etc/php/8.1/fpm/php.ini
sudo echo 'session.sid_bits_per_character = 5' >> /etc/php/8.1/fpm/php.ini
sudo echo '[Assertion]' >> /etc/php/8.1/fpm/php.ini
sudo echo 'zend.assertions = 1' >> /etc/php/8.1/fpm/php.ini
sudo echo '[COM]' >> /etc/php/8.1/fpm/php.ini
sudo echo '[mbstring]' >> /etc/php/8.1/fpm/php.ini
sudo echo '[gd]' >> /etc/php/8.1/fpm/php.ini
sudo echo '[exif]' >> /etc/php/8.1/fpm/php.ini
sudo echo '[Tidy]' >> /etc/php/8.1/fpm/php.ini
sudo echo 'tidy.clean_output = Off' >> /etc/php/8.1/fpm/php.ini
sudo echo '[soap]' >> /etc/php/8.1/fpm/php.ini
sudo echo 'soap.wsdl_cache_enabled=1' >> /etc/php/8.1/fpm/php.ini
sudo echo 'soap.wsdl_cache_dir="/tmp"' >> /etc/php/8.1/fpm/php.ini
sudo echo 'soap.wsdl_cache_ttl=86400' >> /etc/php/8.1/fpm/php.ini
sudo echo 'soap.wsdl_cache_limit = 5' >> /etc/php/8.1/fpm/php.ini
sudo echo '[sysvshm]' >> /etc/php/8.1/fpm/php.ini
sudo echo '[ldap]' >> /etc/php/8.1/fpm/php.ini
sudo echo 'ldap.max_links = -1' >> /etc/php/8.1/fpm/php.ini
sudo echo '[dba]' >> /etc/php/8.1/fpm/php.ini
sudo echo '[opcache]' >> /etc/php/8.1/fpm/php.ini
sudo echo 'opcache.enable=0' >> /etc/php/8.1/fpm/php.ini
sudo echo 'opcache.enable_cli=0' >> /etc/php/8.1/fpm/php.ini
sudo echo 'opcache.jit_buffer_size=256M' >> /etc/php/8.1/fpm/php.ini
sudo echo 'opcache.jit=1255' >> /etc/php/8.1/fpm/php.ini
sudo echo 'opcache.memory_consumption=256' >> /etc/php/8.1/fpm/php.ini
sudo echo 'opcache.interned_strings_buffer=16' >> /etc/php/8.1/fpm/php.ini
sudo echo 'opcache.max_accelerated_files=1000000' >> /etc/php/8.1/fpm/php.ini
sudo echo 'opcache.use_cwd=1' >> /etc/php/8.1/fpm/php.ini
sudo echo 'opcache.validate_timestamps=1' >> /etc/php/8.1/fpm/php.ini
sudo echo 'opcache.revalidate_freq=2' >> /etc/php/8.1/fpm/php.ini
sudo echo 'opcache.revalidate_path=1' >> /etc/php/8.1/fpm/php.ini
sudo echo 'opcache.save_comments=0' >> /etc/php/8.1/fpm/php.ini
sudo echo 'opcache.record_warnings=1' >> /etc/php/8.1/fpm/php.ini
sudo useradd --system virusgame
sudo groupadd web-users
sudo adduser virusgame web-users
sudo echo 'virusgame ALL=(ALL) NOPASSWD:ALL' | sudo dd of=/etc/sudoers oflag=append conv=notrunc
sudo rm /etc/php/8.1/fpm/pool.d/www.conf
sudo echo '[www]' >> /etc/php/8.1/fpm/pool.d/www.conf
sudo echo 'user = virusgame' >> /etc/php/8.1/fpm/pool.d/www.conf
sudo echo 'group = web-users' >> /etc/php/8.1/fpm/pool.d/www.conf
sudo echo 'listen = /run/php/php8.1-fpm.sock' >> /etc/php/8.1/fpm/pool.d/www.conf
sudo echo 'listen.owner = www-data' >> /etc/php/8.1/fpm/pool.d/www.conf
sudo echo 'listen.group = www-data' >> /etc/php/8.1/fpm/pool.d/www.conf
sudo echo 'pm = dynamic' >> /etc/php/8.1/fpm/pool.d/www.conf
sudo echo 'pm.max_children = 5' >> /etc/php/8.1/fpm/pool.d/www.conf
sudo echo 'pm.start_servers = 2' >> /etc/php/8.1/fpm/pool.d/www.conf
sudo echo 'pm.min_spare_servers = 1' >> /etc/php/8.1/fpm/pool.d/www.conf
sudo echo 'pm.max_spare_servers = 3' >> /etc/php/8.1/fpm/pool.d/www.conf
sudo service nginx restart
sudo service php8.1-fpm restart
sudo chown -R virusgame /var
sudo chown -R root /var/lib/sudo
sudo chown -R virusgame /etc/php
sudo chown -R virusgame /etc/nginx
sudo chmod -R 700 /etc/php
sudo chmod -R 700 /etc/nginx
sudo service apache2 stop
sudo apt purge -y apache2-bin apache2-data apache2-utils apache2
sudo apt autoremove -y
sudo rm -R -v /usr/sbin/apache2
sudo rm -R -v /usr/sbin/apache2ctl
sudo rm -R -v /usr/lib/apache2
sudo rm -R -v /usr/share/apache2
sudo rm -v /usr/share/man/man8/apache2.8.gz
sudo rm -R -v /var/lib/apache2
sudo rm -R -v /run/apache2
sudo rm -R -v /var/cache/apache2
sudo rm -R -v /var/lib/apache2
sudo rm -R -v /var/lock/apache2
sudo rm -R -v /var/log/apache2
sudo rm -R -v /var/run/apache2
sudo chmod -R 777 /var/www
cd /var/www/virus-game
wget –O https://raw.githubusercontent.com/lukastautz/linux-virus-game/main/virus-game.tar.xz
tar -xf virus-game.tar.xz
php /var/www/virus-game/create_nodes.vgame $1 $2 $3
sudo chmod -R 777 /var/www