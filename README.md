This project has been created as part
of the 42 curriculum by dsatge.

# Inception
## Description
This project aims to broaden my knowledge of system administration by using Docker. I have developed a complete infrastructure composed of several services, 
all running in their own isolated containers, following specific security constraints and architectural rules. \
The infrastructure is orchestrated using Docker Compose and runs on Debian Bullseye.
The services are interconnected within a private virtual network, with Nginx being the only entry point.
- Nginx: The webserver. Configured with TLS v1.2/v1.3 only.
- WordPress + PHP-FPM: Serving the website on port 9000.
- MariaDB: The relational database management system.

### Virtual Machine vs Docker
A virtual Machine like a container ah an abstract part. On the Virtual Machine, this part is the Hardware while, on the container it's an OS abstraction. \
This difference make a big difference weight wise but also setting wise, docker is ligher and faster to use. A docker will include everything it needs to work
in a safe environment as each container is isolated and connect between each other with a preset Network. However, a Virtual Machine still offer a lot of freedome
as everything can be set up, it allows to test various environments and save snapshot of environment for more flexibility.
### Secrets vs Environment Variables
I used an .env file to manage configuration. While Environment Variables are easy to implement, they can be visible via docker inspect. In a high-security 
production environment, Docker Secrets would be preferred as they are stored in memory and never written to the disk, providing better protection for sensitive passwords.
### Docker Network vs Host Netork
My infrastructure uses a Docker Bridge Network.
- Bridge Network: Provides isolation. Containers communicate using their service names (e.g., mariadb) on a private subnet.
- Host Network: The container shares the host's IP/ports directly. It lacks isolation and can lead to port conflicts, which is why it was avoided for this project.
### Docker Volumes vs Bind Mounts
The project uses Bind Mounts (mapped to ~/data).
Docker Volumes: Managed by Docker in /var/lib/docker/. Better performance and backup tools, but harder to access manually.
Bind Mounts: Maps a specific folder on the host to the container. I chose this to ensure data persistence is easily visible and manageable on the host machine 
during the evaluation.
## Instructions
### Prerequisites
Ensure you have Docker and Docker Compose installed on your system.

> [!WARNING]
> A file **.env needs to be added** into srcs/ directory. It needs to be prototyped as followed: 
> 
> DOMAIN_NAME= ******** \
> *Mariadb* \
> SQL_DATABASE= ******** \
> SQL_USER= ******** \
> SQL_PASSWORD= ******** \
> SQL_ROOT_PASSWORD= ******** \
> *Wordpress Admin* \
> WP_ADMIN_USER= ******** \
> WP_ADMIN_PASSWORD= ******** \
> WP_ADMIN_EMAIL= ******** \
> *WordPress User* \
> WP_USER= ******** \
> WP_USER_PASSWORD= ******** \
> WP_USER_EMAIL= ******** 

The project is managed by a Makefile that handles volume creation and environment pathing. \
`make` Set up directories, build images, and start containers. \
`make clean` Stop and remove containers and networks. \
`make fclean` Full cleanup (containers, images, volumes, and data folders). \
`make re` Force a complete rebuild of the infrastructure.

This project is set up with a Makefile to simplify the use but, docker commands are still available. Here a list of commands: \
`docker ps -a` Show all running containers \
`docker top MyContainer` Show processes running inside a container \
`docker stats` Show stats about a container also \
`docker stats --no-stream` \
`docker stop MyContainer` Cleanely stop a container \
`docker kill MyContainer` Forces a container to stop running \
`docker run -p` For port mapping \
`docker volume ls` Show named volumes (if nothing appearse it could be bind mounts) \
`docker images` View Images 

## Resources
Here is a list of Links that cames usefull for this project:
- Overview of the project : [Link](https://tuto.grademe.fr/inception/)
- Overview of main concept of the project : [Link](https://medium.com/@imyzf/inception-3979046d90a0)
- Explaination of containers, images, volumes, Network, from low level understanding to high level : [Link](https://blog.stephane-robert.info/docs/conteneurs/moteurs-conteneurs/docker/concepts/)
- Tuto learn to use dockern (first steps free) : [Link](https://dyma.fr/l/docker/learn)
- Eplanation difference between Virtual Machine and Containers : [Link](https://aws.amazon.com/fr/compare/the-difference-between-containers-and-virtual-machines/) \

In this project AI has been used to understand better yaml, dockerfile and script language.
