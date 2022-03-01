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
