# Mibew Messenger Docker image

[Mibew Messenger](https://mibew.org/) (also known as Open Web Messenger) is an open-source live support application written in PHP and MySQL. It enables one-on-one chat assistance in real-time directly from your website.


This repository contains the Dockerfile for the [mibew messenger docker image](https://hub.docker.com/repository/docker/takisrs/mibew)

## How to use
Use a **config.yml** file to keep the necessary configuration.  
[Download config file](https://raw.githubusercontent.com/Mibew/mibew/master/src/mibew/configs/default_config.yml)

Provide valid credentials for a mysql database in the **config.yml** file.

Run the container:  
```docker container run -d -p 80:80 -v config.yml:/var/www/html/configs/config.yml --name mibew_messenger takisrs/mibew```

## How to run mibew messenger easily (docker-compose)
Alternatively, you may clone this repository and run the following command to create the required containers and test mibew messenger easily:  
```docker-compose up```

