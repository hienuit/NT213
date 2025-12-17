#!/bin/bash
set -e

echo "[1] Cài đặt Python pip"
sudo apt-get update
sudo apt-get install -y python3-pip

echo "[2] cd FUGIO"
cd FUGIO

echo "[3] Cài Docker"
sudo apt install -y docker.io

echo "[4] Cài Apache2"
sudo apt update
sudo apt install -y apache2

echo "[5] Add repo PHP 7.2"
sudo add-apt-repository ppa:ondrej/php -y
sudo apt update

echo "[6] Cài PHP 7.2 + extension"
sudo apt install -y \
    php7.2 php7.2-cli php7.2-dev php7.2-xml \
    php7.2-mbstring php7.2-curl php7.2-zip \
    php7.2-common libapache2-mod-php7.2

echo "[7] Cài Composer"
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php composer-setup.php
php -r "unlink('composer-setup.php');"
sudo mv composer.phar /usr/local/bin/composer

echo "[8] Cấu hình AllowOverride All"
sudo sed -i '/<\/VirtualHost>/i <Directory /var/www/html>\n    AllowOverride All\n</Directory>\n' \
    /etc/apache2/sites-available/000-default.conf

echo "[9] Restart Apache"
sudo systemctl restart apache2

echo "[10] Chạy RabbitMQ"
chmod +x run_rabbitmq.sh
sudo ./run_rabbitmq.sh

echo "[11] Cài PHP 7.2 local dependencies"
chmod +x install_72.sh
sudo ./install_72.sh

echo "[12] Bật .htaccess thông qua script"
chmod +x htaccess.py
sudo ./htaccess.py on

echo "[13] Copy vulnerable_app vào Apache"
sudo cp -r vulnerable_app /var/www/html/

echo "==============================="
echo "Cài đặt hoàn tất!"
echo "Chạy 2 terminal để test FUGIO:"
echo ""
echo "Terminal 1:"
echo "  cd FUGIO"
echo "  sudo systemctl restart apache2"
echo "  sudo chmod +x run_FUGIO_72.sh "
echo "  sudo chmod +x run.py"
echo "  sudo ./run_FUGIO_72.sh vulnerable_app --doc_root=/var/www/html"
echo ""
echo "Terminal 2:"
echo "  cd FUGIO"
echo "  sudo chmod +x trigger_poc.py"
echo "  python3 vulnerable_app/trigger_poc.py http://127.0.0.1/vulnerable_app/"
echo "==============================="
