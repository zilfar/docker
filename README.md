# Docker

## Why Docker
Very fast, lightweight and secure.<br>
Containers are built on the same kernel instead of virtualising new kernels, which makes it much faster. The containers are very isolated and have no idea they are only a container, makes it very secure and difficult to gain access to the rest of the system and other containers, especially in a microservices architecture.<br>

## To Install Docker
To install docker: https://docs.docker.com/desktop/windows/install/<br>
`docker --version`<br>
Make an account on Docker.com, and then log in on the terminal.<br>
`docker login`<br>

## Using Docker
From here, you can run containers, commit images and push them to your own repositories.<br>
To run a container:<br>
`docker run -d -t -p hostport:containerport --name nameofcontainer imagename`<br>
- Where `-d` means 'detached' (running in background), 
- `-t` means 'terminal' (allows you to access the container using a terminal), 
- and `-p` means "port" (lets you map the port of the host to the container)
- The --name flag names the container which makes it easier to reference, and the image name is the name of the image file you'll be using to launch the container for (e.g. nginx)

Example command:<br>
`docker run -d -t -p 80:2368 --name ghostcontainer ghost`<br>
If the image isn't found locally, it will autoamtically pull and download it from the online docker repositories.<br><br>
To copy a file from host to container:<br>
`docker cp file_source_name.txt container_name:/path/to/destination/file.txt`<br>
Example command: `docker cp index.html nginx:/usr/share/nginx/html/index.html`<br><br>
To use bash commands within your container: `docker exec -it container_name bash`<br><br>
After making changes, you can commit changes:<br>
`docker commit containername username/repository:tag`<br>
Example command:`docker commit nginx zfarik/nginx_yeye:latest`<br><br>
From here on, we can push these changes to the repository online so it can be accessed from anywhere with docker:<br>
`docker push zfarik/nginx_yeye:latest`

## Dockerfile

```docker
# from which image - image we used as our base image
FROM nginx

# label to communicate with team members
LABEL MAINTAINER=ZFARIK

# copy data from localhost to container
COPY index.html /usr/share/nginx/html/

# expose the port (80)
EXPOSE 80

# launch/create a container
CMD ["nginx", "-g", "daemon off;"]
```

After building a dockerfile, you can use this command to build an image from it:<br>
`docker build -t username/repositoryname pathtodockerfile`<br>
Example command: `docker build -t zfarik/nginx_yeye .`
<br><br>
From here, we can push this image to our docker repository online:<br>
`docker image push zfarik/nginx_yeye`, the default tag is `latest`.<br>

Creating our app in a Dockerfile (since it's a Node.js app) is a lot easier:<br>
```dockerfile
FROM node:8

COPY app /home/node/
WORKDIR /home/node/
RUN apt-get update 
RUN npm install


EXPOSE 3000

CMD ["npm", "start"] 
```
## Multi-app Container Deployment
- Docker-compose is a service that is used to run multi-app containers
- One image can reference the other image by using its name
- We use `link` attributes to connect two services
- One image can depend on another image running first
- Can run health checks and only launch CMD commands after a successful health check ping
- The file has to be called `docker-compose.yml`
- Command prefixes are `docker-compose`<br><br>
Our docker-compose file:<br>
```yml
version: "3"
services:
      mongo:
            container_name: mongo
            image: mongo
            volumes:
              - ./data:/data/db
            ports:
              - '27018:27017'
            healthcheck:
              test: echo 'db.runCommand("ping").ok' | mongo mongo:27017/posts --quiet
              interval: 5s
              timeout: 5s
              retries: 8
      app:
            container_name: app
            image: zfarik/nodeapp
            restart: always
            # build: .
            ports:
              - "80:3000"
            links:
              - mongo
            depends_on:
                mongo:
                  condition: service_healthy
```
Anyone can copy and paste this docker-compose.yml file onto their systems and launch this using docker with `docker-compose up` in the same directory, and it will launch the app successfully, completely containerised. 