FROM ubuntu:20.04
RUN apt-get update
RUN apt-get install -y openjdk-17-jdk
COPY demo1-0.0.1-SNAPSHOT.jar .
EXPOSE 8080
CMD ["java","-jar","demo1-0.0.1-SNAPSHOT.jar"]
