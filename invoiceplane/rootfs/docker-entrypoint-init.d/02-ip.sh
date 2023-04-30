#!/bin/sh
#DocumentRoot=$(bashio::config 'document_root')

if [ -L /var/www/html ]; then
  if [ -f /var/www/html/ipconfig.php ]; then
    echo "Simbolična povezava /var/www/html obstaja in datoteka ipconfig.php je prisotna."
  else
    echo "Simbolična povezava /var/www/html obstaja, vendar datoteka ipconfig.php ni prisotna."
  fi
else
  echo "Simbolična povezava /var/www/html ne obstaja."
  echo "InvoicePlane ni nameščen."
  
  if [ -d /share/invoiceplane ]; then
    echo "Mapa /share/invoiceplane obstaja."
  else
    echo "Mapa /share/invoiceplane ne obstaja."
    echo "NAPAKA"
    exit 1
  fi
  
  if [ "$(stat -c '%U:%G:%a' /share/invoiceplane)" = "nobody:nobody:755" ]; then
    echo "Mapa /share/invoiceplane ima prava dovoljenja."
  else
    echo "Mapa /share/invoiceplane nima pravih dovoljenj."
    echo "NAPAKA"
  fi

  echo "Nameščam..."
  
  # Preveri, ali je dosegljiva povezava do GitHuba
  echo "Datoteka je prisotna na GITHUB-u...ok"
  if ! curl --output /dev/null --silent --head --fail "https://github.com/InvoicePlane/InvoicePlane/releases/download/v1.6.1-beta-2/v1.6.1-beta-2.zip"; then
    echo "Ni mogoče prenesti InvoicePlane. Povezava do GitHuba ni na voljo."
    exit 1
  fi

  # Prenesi InvoicePlane
  echo "InvoicePlane se prenaša iz GITHUB-a...ok"
  curl -LJO https://github.com/InvoicePlane/InvoicePlane/releases/download/v1.6.1-beta-2/v1.6.1-beta-2.zip

  # Razpakiraj arhiv v mapo /share/invoiceplane
  echo "Dearhiviranje datoteke se je pričel...ok"
  unzip v1.6.1-beta-2.zip -d /share/invoiceplane
  # Odstrani preneseni arhiv
  echo "Arhivska datoteka bo odstranjena...ok"
  rm -f v1.6.1-beta-2.zip
  # prestavim vsebino iz ip mape v /var/www/html
  mv /share/invoiceplane/ip/* /share/invoiceplane
  # zbrišem prazno mapo ip
  rm -r /share/invoiceplane/ip
  # kopira datoteko ipconfig.php.example v ipconfig.php
  cp /share/invoiceplane/ipconfig.php.example /share/invoiceplane/ipconfig.php
  # ustvari simbolični link med /share/invoiceplane in /var/www/
  ln -s /share/invoiceplane /var/www/

  
    # Preveri, ali je mapa /var/www/invoiceplane pravilno viden
    if [ -f "/var/www/html/ipconfig.php" ]; then
    # Sporoči, da je bila namestitev InvoicePlane uspešna
    echo "InvoicePlane je bil uspešno nameščen v /var/www/invoiceplane/."
    else
    echo "NAPAKA"
    exit 1
  


    fi
  
fi
