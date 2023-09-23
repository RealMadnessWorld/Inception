<div align=center>
  <h1>
    Inception
  </h1>
	
> The purpose of the infrastructure is to have a running WordPress site. A WordPress site needs to have a database, for that the app uses MariaDB
> as the database management system. NGINX will serve as a reverse proxy server for WordPress requests.
</div>

---

<div align=center>
  <h2>
    Description
  </h2>
</div>

The main goal of this project is to build a small infrastructure composed of different services under specific rules using Docker.<br>
It consists of creating a Docker app - by building custom Docker images for each service and managing them with the docker compose command.<br>
The required services of the Inception App are `NGINX`, `MariaDB` and `WordPress`.

---

<div align=center>
  <h2>
    Technologies
  </h2>

<img src="https://github.com/devicons/devicon/blob/master/icons/docker/docker-original-wordmark.svg" title="Docker" alt="Docker" width="60" height="60"/>&nbsp;
<img src="https://github.com/devicons/devicon/blob/master/icons/nginx/nginx-original.svg" title="NGINX" alt="NGINX" width="60" height="60"/>&nbsp;
<img src="https://www.vectorlogo.zone/logos/mariadb/mariadb-icon.svg" title="MariaDB" alt="MariaDB" width="60" height="60"/>
<img src="https://github.com/RealMadnessWorld/Inception/assets/76601093/e97db32a-604c-4b93-9b1f-948d28aae9b8" title="Wordpress" alt="Wordpress" width="60" height="60"/>&nbsp;
</div>

---

<div align=center>
  <h2>
	How to run
  </h2>
</div>

- Install Docker: [install Docker engine official docs](https://docs.docker.com/engine/install/)  
- Clone this repository:

    	git clone https://github.com/RealMadnessWorld/Inception
- Navigate to Inception: 

		cd Inception
- Write a `.env` file like the one on srcs/.env.example to use your very own configurations  
- Run `make` with sudo privileges:

  		sudo make
<h4>
  Makefile commands:
</h4>

  - ```make``` or ```make up``` (will create the containers and set everything up)
  - ```make down``` (will delete all the containers leaving only the volumes)
  - ```make delete``` (does the same as ```make down``` but also deletes all volumes)

---

<div align="center">
	<img src="https://user-images.githubusercontent.com/76601093/193692098-d4b16956-1dab-40b8-9aae-31b254efc5ee.jpg" width=340> <img src="https://github.com/RealMadnessWorld/Inception/assets/76601093/b9621474-0a34-4e08-be66-426ab97e8232">

</div>
