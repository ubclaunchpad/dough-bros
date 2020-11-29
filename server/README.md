# Docker Compose + MySQL Setup & Instructions:

*Note: In the docker-compose.yml, make sure the volume is pointing at the corresponding workspace paths!!*


# Server Setup

* Run `docker-compose build` to build containers from Docker.
* Run `docker-compose up` to pull containers from Docker.
* An instance of mySQL will be running at *localhost:3306*
* Server application is running at *localhost:8000*
* Run `docker-compose down` or `Ctrl+C` to gracefully stop containers.

# Code Maintenance

* Run `npm run lint` to make sure your code follows code standard rules 
is formatted before creating a pull request on GitHub.