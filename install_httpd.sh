#! /bin/bash
sudo yum update
sudo yum install httpd
sudo yum install java
echo "<h2>Webserver from terra..</h2>" > /var/www/public_html
sudo systemctl restart httpd
sudo systemctl enable httpd