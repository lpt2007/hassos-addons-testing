#!/bin/sh
#DocumentRoot=$(bashio::config 'document_root')

# Preveri, ali je mapa /share/invoiceplane že nameščena
if [ -f "/var/www/html/ipconfig.php" ]; then
  echo "InvoicePlane je že nameščen."
#  exit 0
else
  echo "InvoicePlane ni nameščen."
  echo "Nameščam..."
  # Preveri, ali je dosegljiva povezava do GitHuba
  if ! curl --output /dev/null --silent --head --fail "https://github.com/InvoicePlane/InvoicePlane/releases/download/v1.6.1-beta-2/v1.6.1-beta-2.zip"; then
    echo "Ni mogoče prenesti InvoicePlane. Povezava do GitHuba ni na voljo."
    exit 1
  fi

  # Prenesi InvoicePlane
  curl -LJO https://github.com/InvoicePlane/InvoicePlane/releases/download/v1.6.1-beta-2/v1.6.1-beta-2.zip

  # Razpakiraj arhiv v mapo /var/www/html/
  unzip v1.6.1-beta-2.zip -d /var/www/html
  # Odstrani preneseni arhiv
  rm -f v1.6.1-beta-2.zip
  # prestavim vsebino iz ip mape v /var/www/html
  mv /var/www/html/ip/* /var/www/html/
  # zbrišem prazno mapo ip
  rm -r /var/www/html/ip
  # kopira datoteko ipconfig.php.example v ipconfig.php
  cp /var/www/html/ipconfig.php.example /var/www/html/ipconfig.php

  # Sporoči, da je bila namestitev InvoicePlane uspešna
  echo "InvoicePlane je bil uspešno nameščen v /var/www/html/."
  
  #if [ -L "/var/www/html" ]; then
  #  echo "Povezava med /share/invoiceplane/ip/ in /var/www/html je že vspostavljena"
  #  exit 1
  #else
  #  echo "Povezava med /share/invoiceplane/ip/ in /var/www/html še ni vspostavljena"
  #  echo "Vzpostavljam..."
  #  ln -s /share/invoiceplane/ip/* /var/www/html/
  #  echo "Mapa uspešno povezana na strežnik"
  #fi

fi
#exit 1
