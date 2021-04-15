#!/bin/bash
    sudo amazon-linux-extras install -y nginx1
    sudo systemctl enable nginx
    sudo systemctl start nginx
    echo "<html><body><p align=center><h1><strong>WELCOME TO MORDOR</strong> </h1></p></body></html>" > /usr/share/nginx/html/index.html