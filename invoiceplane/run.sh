#!/usr/bin/with-contenv bashio
ssl=$(bashio::config 'ssl')
website_name=$(bashio::config 'website_name')
certfile=$(bashio::config 'certfile')
keyfile=$(bashio::config 'keyfile')
DocumentRoot=$(bashio::config 'document_root')
phpini=$(bashio::config 'php_ini')
username=$(bashio::config 'username')
password=$(bashio::config 'password')
default_conf=$(bashio::config 'default_conf')
default_ssl_conf=$(bashio::config 'default_ssl_conf')
webrootdocker=/var/www/localhost/htdocs/
phppath=/etc/php81/php.ini

if [ $phpini = "get_file" ]; then
	cp $phppath /share/nginxaddon_php.ini
	echo "You have requested a copy of the php.ini file. You will now find your copy at /share/nginxaddon_php.ini"
	echo "Addon will now be stopped. Please remove the config option and change it to the name of your new config file (for example /share/php.ini)"
	exit 1
fi

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
	echo "A default website will now be used"
	mkdir $webrootdocker
	cp /index.html $webrootdocker
else
	#Create Shortcut to shared html folder
	ln -s $DocumentRoot /var/www/localhost/htdocs/
fi

#Set rights to web folders and create user
if [ -d $DocumentRoot ]; then
	find $DocumentRoot -type d -exec chmod 771 {} \;
	if [ ! -z "$username" ] && [ ! -z "$password" ] && [ ! $username = "null" ] && [ ! $password = "null" ]; then
		adduser -S $username -G nginx
		echo "$username:$password" | chpasswd $username
		find $webrootdocker -type d -exec chown $username:nginx -R {} \;
		find $webrootdocker -type f -exec chown $username:nginx -R {} \;
	else
		echo "No username and/or password was provided. Skipping account set up."
	fi
fi

if [ $phpini != "default" ]; then
	if [ -f $phpini ]; then
		echo "Your custom php.ini at $phpini will be used."
		rm $phppath
		cp $phpini $phppath
	else
		echo "You have changed the php_ini variable, but the new file could not be found! Default php.ini file will be used instead."
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
