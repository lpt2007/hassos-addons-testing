#!/usr/bin/with-contenv bashio
ssl=$(bashio::config 'ssl')
website_name=$(bashio::config 'website_name')
certfile=$(bashio::config 'certfile')
keyfile=$(bashio::config 'keyfile')
DocumentRoot=$(bashio::config 'document_root')
username=$(bashio::config 'username')
password=$(bashio::config 'password')
default_conf=$(bashio::config 'default_conf')
default_ssl_conf=$(bashio::config 'default_ssl_conf')
webrootdocker=/var/www/localhost/htdocs/

if bashio::config.has_value 'init_commands'; then
    echo "Detected custom init commands. Running them now."
    while read -r cmd; do
        eval "${cmd}" ||
            bashio::exit.nok "Failed executing init command: ${cmd}"
    done <<<"$(bashio::config 'init_commands')"
fi

rm -r $webrootdocker

if [ ! -d $DocumentRoot ]; then
    echo "You haven't put your website to $DocumentRoot"
    echo "DEBUGGING: $certfile $website_name $ssl"
    echo "A default website will now be used"
    mkdir $webrootdocker
    cp /index.html $webrootdocker
else
    #Create Shortcut to shared html folder
    ln -s $DocumentRoot /var/www/localhost/htdocs
fi

#Set rights to web folders and create user
if [ -d $DocumentRoot ]; then
    find $DocumentRoot -type d -exec chmod 771 {} \;
    if [ ! -z "$username" ] && [ ! -z "$password" ] && [ ! $username = "null" ] && [ ! $password = "null" ]; then
        adduser -S $username -G www-data
        echo "$username:$password" | chpasswd $username
        find $webrootdocker -type d -exec chown $username:www-data -R {} \;
        find $webrootdocker -type f -exec chown $username:www-data -R {} \;
    else
        echo "No username and/or password was provided. Skipping account set up."
    fi
fi

if [ $ssl = "true" ] && [ $default_conf = "default" ]; then
    echo "You have activated SSL. SSL Settings will be applied"
    if [ ! -f /ssl/$certfile ]; then
        echo "Cannot find certificate file $certfile"
        exit 1
    fi
    if [ ! -f /ssl/$keyfile ]; then
        echo "Cannot find certificate key file $keyfile"
        exit 1
    fi
    mkdir /etc/nginx/conf.d
    sed -i '/user/s/^# //g' /etc/nginx/nginx.conf
    sed -i '/access_log/s/^/# /g' /etc/nginx/nginx.conf
    echo "upstream php-upstream { server php:9000; }" > /etc/nginx/conf.d/upstream.conf
    echo "server {" > /etc/nginx/conf.d/default.conf
    echo "    listen 80;" >> /etc/nginx/conf.d/default.conf
    echo "    server_name $website_name;" >> /etc/nginx/conf.d/default.conf
    echo "    return 301 https://\$host\$request_uri;" >> /etc/nginx/conf.d/default.conf
    echo "}" >> /etc/nginx/conf.d/default.conf
    echo "server {" > /etc/nginx/conf.d/default-ssl.conf
    echo "    listen 443 ssl http2;" >> /etc/nginx/conf
