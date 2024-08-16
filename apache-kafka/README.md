# Introduction to Kafka

Official [Docs](https://kafka.apache.org/)
 
## Building a Docker file

As always, we start with a `dockerfile` </br> 
We can build our `dockerfile`
```
cd .\docker-projects\kafka\kafka\
docker build . -t local/kafka:3.1.0
```  
## Exploring the Kafka Install 

We can then run it to explore the contents:
```
docker run --rm --name kafka -it local/kafka:3.1.0 bash
ls -l /kafka/bin/
cat /kafka/config/server.properties
```
We can use the `docker cp` command to copy the file out of our container:
```
docker cp kafka:/kafka/config/server.properties ./server.properties
docker cp kafka:/kafka/config/zookeeper.properties ./zookeeper.properties
```  
Note: We'll need the Kafka configuration to tune our server and Kafka also requires at least one Zookeeper instance in order to function. To achieve high availability, we'll run multiple kafka as well as multiple zookeeper instances in the future .

# Zookeeper

Let's build a Zookeeper image. The Apache folks have made it easy to start a Zookeeper instance the same way as the Kafka instance by simply running the `start-zookeeper.sh` script. 
```
cd ./docker-projects/kafka/zookeeper
docker build . -t local/zookeeper:3.1.0
cd ..
```  
Let's create a kafka network and run 1 zookeeper instance 
```
docker network create kafka
docker run -d `
--rm `
--name zookeeper `
--net kafka `
-v ${PWD}/config/zookeeper/zookeeper.properties:/kafka/config/zookeeper.properties `
local/zookeeper:3.1.0 

docker logs zookeeper
```  

# Kafka   
```
docker run -d `
--rm `
--name kafka `
--net kafka `
-v ${PWD}/config/kafka/server.properties:/kafka/config/server.properties `
local/kafka:3.1.0  

docker logs kafka
```
  

## Start the containers

```
cd docker-projects\kafka\ 

docker compose build

docker compose up
```