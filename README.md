# Mibew Messenger Docker image

[Mibew Messenger](https://mibew.org/) (also known as Open Web Messenger) is an open-source live support application written in PHP and MySQL. It enables one-on-one chat assistance in real-time directly from your website.


This repository contains the Dockerfile for the [mibew messenger docker image](https://hub.docker.com/repository/docker/takisrs/mibew)

## How to use
Use a **config.yml** file to keep the necessary configuration.  
[Download config file](https://raw.githubusercontent.com/Mibew/mibew/master/src/mibew/configs/default_config.yml)

Provide valid credentials for a mysql database in the **config.yml** file, as well as other settings for email, etc.

## Styling

The directory styles contains the default styles that are delivered with mibew (version 3.5.4). The directory is mounted to the mibew styles directory in the container.
You may remove the corresponding volume entry in docker-compose.yml if don't wan't to modify the styles (from outside the container).



## Run the container:  
```bash
docker container run -d -p 80:80 -v config.yml:/var/www/html/configs/config.yml --name mibew_messenger takisrs/mibew
```

## How to run mibew messenger easily (docker-compose)
Alternatively, you may clone this repository and run the following command to create the required containers and test mibew messenger easily:  
```bash
docker-compose up
```

## Run Setup

Go to: http://localhost:8080/mibew/install.php
