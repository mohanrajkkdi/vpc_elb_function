#!/bin/bash
sudo yum update -y
sudo yum install httpd -y
sudo yum install java -y
echo "<h2>Webserver from terra..</h2>" | sudo tee /var/www/html/index.html
sudo systemctl start httpd
sudo systemctl enable httpd