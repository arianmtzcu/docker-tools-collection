# MongoDB &amp; Mongo-Express
> mongo-express [https://hub.docker.com/_/mongo-express]

### Docker containers & MongoDB
[Docker](https://www.bmc.com/blogs/docker-101-introduction/)  is a tool to create, deploy, and run applications using containers easily. A  [container](https://www.bmc.com/blogs/what-is-a-container-containerization-explained/)  is a standard unit of software that can be used to package applications and all the dependencies to a single package. These containers can be run on any server platform regardless of the underlying configuration or hardware structure.

Docker can be used to run MongoDB instances. Setting up MongoDB as a container allows the user to create a portable and extensible NoSQL database. A containerized MongoDB instance behaves exactly like a non-containerized MongoDB instance without having to worry about the underlying configuration.

### Steps:
1. Install Docker
2. Create the defined directory to save data (example: /docker/mongodb/database/)
3. Copy the **.yml** file into workspace (example: /docker/mongodb/) and configure the necessary properties for your development environment. 
4. Open a console and go to the example directory: /docker/mongodb/
5. Run the command: **`docker-compose up -d`**

 **Note:** check the health status of the services:
>**mongodb** [http://localhost:27017/test] || [echo ''db.runCommand("ping").ok'']

>**mongo-express** [http://localhost:8081/] 
> user: admin
> password: admin123