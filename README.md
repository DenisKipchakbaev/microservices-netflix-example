Spring Cloud Netflix based Microservices example project.

As a base was taken examples of the Microservices in Action book by John Carnell: 
https://github.com/carnellj/spmia_overview

Project microservices configured to run as docker containers as well as separate Spring Boot applications.

# Introduction
This example project include:

1.  A Spring Cloud Config server that is deployed as Docker container and can manage a services configuration information using a file system or GitHub-based repository.
2.  A Eureka server running as a Spring-Cloud based service.  This service will allow multiple service instances to register with it.  Clients that need to call a service will use Eureka to lookup the physical location of the target service.
3.  A Zuul API Gateway.  All of our microservices can be routed through the gateway and have pre, response and post policies enforced on the calls.
4.  A Spring Cloud based OAuth2 authentication service that can issue and validate OAuth2 tokens.
5.  A Zipkin distributed tracing platform.
6.  A Kafka message bus to transport messages between services.
7.  A Postgres SQL database used to hold the business data.
8.  A Redis service to act as a distributed cache.

Custom example business services:
9.  A licensing service that will manage licensing data used within a company.
10. An organization service that will manage client organization data used within a company.
11. ==TODO==A new version of the organization service.  This service is used to demonstrate how to use the Zuul API gateway to route to different versions of a service.
12. ==TODO==A special routes services that the the API gateway will call to determine whether or not it should route a user's service call to a different service then the one they were originally calling.  This service is used in conjunction with the orgservice-new service to determine whether a call to the organization service gets routed to an old version of the organization service vs. a new version of the service.


# Software needed
1.  [Java 8]
2.	[Apache Maven] (http://maven.apache.org).
3.	[Docker] (http://docker.com). Docker V1.12 and above. I am taking advantage of the embedded DNS server in Docker that came out in release V1.11.
4.	[Git Client] (http://git-scm.com).

# Building the Docker Images
To build the code examples as a docker image, open a command-line window change to the directory where you have downloaded the source code.

Run the following maven command.  This command will execute the [Spotify docker plugin](https://github.com/spotify/docker-maven-plugin) defined in the pom.xml file.  
   
   **mvn -Denv.BUILD_NAME=final clean package docker:build**

If everything builds successfully you should see a message indicating that the build was successful.

# Running the services in Docker

Now we are going to use docker-compose to start the actual image.  To start the docker image,
change to the directory containing  your source code.  Issue the following docker-compose command:

   **export BUILD_NAME=final && docker-compose -f docker/common/docker-compose.yml up**

If everything starts correctly you should see a bunch of Spring Boot information fly by on standard out.  At this point all of the services needed for the chapter code examples will be running.

# Running the services as Spring Boot applications

To run in STS:
- Import as Maven projects

- To work with encrypted passwords Oracle JCE java encryption libs required.


note: OpenJDK comes with preinstalled JCE libs
A quick test to see if you have the JCE Unlimited Strength Jurisdiction Policy files installed: 

  **$JAVA_HOME/bin/jrunscript -e 'print (javax.crypto.Cipher.getMaxAllowedKeyLength("RC5") >= 256);'**

installation (adjust for your JDK dir):

cd /tmp/ && \
	curl -k -LO "http://download.oracle.com/otn-pub/java/jce/8/jce_policy-8.zip" -H 'Cookie: oraclelicense=accept-securebackup-cookie' && \
	unzip jce_policy-8.zip && \
	rm jce_policy-8.zip && \
	yes | sudo cp -v /tmp/UnlimitedJCEPolicyJDK8/*.jar /usr/lib/jvm/java-8-openjdk-amd64/jre/lib/security/


- In 'Run Configurations' for Spring Boot apps: 
	authentication-server 
	licensing-service
	organisation-service

configure:

profile: local   (to use authenticationservice-local.yml file in from git config repo)
Environment variables:
ENCRYPT_KEY=IMSYMMETRIC
(The key used to encrypt passwords. All services with encrypted properties in config require ENCRYPT_KEY environment variable)


- Start postgres, kafka, redis, logspout as docker containers:

   **docker-compose -f docker/local/docker-compose.yml up**
   
- Start Spring Boot apps, starting from config-server and eureka
