echo "Pushing service docker images to docker hub ...."
docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD
docker push kipc/sandbox-authentication-server:$BUILD_NAME
docker push kipc/sandbox-licensing-service:$BUILD_NAME
docker push kipc/sandbox-organization-service:$BUILD_NAME
docker push kipc/sandbox-config-server:$BUILD_NAME
docker push kipc/sandbox-eureka-server:$BUILD_NAME
docker push kipc/sandbox-zuul-server:$BUILD_NAME
