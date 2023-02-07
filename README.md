<div align=center>
  <h1>
    Inception
  </h1>
  <p> Project to create various docker containers </p>
</div>

---

<div align=center>
  <h2>
    Commands and other info
  </h2>
</div>

<h4>
  Requirements:
</h4>

  - [x] docker
  - [x] docker-compose

<h4>
  Makefile commands:
</h4>

  - ```make``` or ```make up``` (will create the containers and set everything up)
  - ```make down``` (will delete all the containers leaving only the volumes)
  - ```make delete``` (does the same as ```make down``` but also deletes all volumes)

---

<h2 align=center>
  Resources
</h2>

[Create a nginx docker container](https://programatically.com/how-to-create-a-custom-dockerfile-of-nginx/)

[Create a self-signed TLS certificate](https://www.linode.com/docs/guides/create-a-self-signed-tls-certificate/)

[mlanca-c's wiki](https://github.com/mlanca-c/inception/wiki) (Best place to understand how this project works, everything is explained in detail there! Also check out [mlanca-c's github](https://github.com/mlanca-c)!)

[Docker-compose build command](https://docs.docker.com/compose/compose-file/build/) (so that you can automatically create an image through a Dockerfile)

