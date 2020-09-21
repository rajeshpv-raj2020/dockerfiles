## Build Image
* Building SonarQube "Developer Edition"; followed https://hub.docker.com/_/sonarqube/ 

* Open in browser https://binaries.sonarsource.com/CommercialDistribution/sonarqube-developer/
* Get list of release numbers available here as "8.3.1.34397 or 8.4.2.36762"
```bash
cd $MY_WORKSPACE/docker/sonarqube
docker build --build-arg SONARQUBE_VERSION=8.2.0.32929 -t rpradesh/sonarqube:8.2.0 .
docker build --build-arg SONARQUBE_VERSION=8.3.1.34397 -t rpradesh/sonarqube:8.3.1 .
docker build --build-arg SONARQUBE_VERSION=8.4.2.36762 -t rpradesh/sonarqube:8.4.2 .
```

## Test Image

```bash
# Step.1: launch or start
docker run --name=sonarqube8_9030_2 -p 9030:9000 -d rpradesh/sonarqube:8.3.1
# or
docker start sonarqube8_9030_2

# Step.2: check when "SonarQube is up"
docker logs -f sonarqube8_9030_2 | grep 'is up'

# Step.3: Login using admin/admin at  http://localhost:9030/projects
# Step.4: (first time) enter license at http://localhost:9030/admin/extension/license/app 
# Step.5: Steps to scan sample: petstore application https://github.com/mybatis/jpetstore-6

# Step.n: if need to stop or delete container
docker stop sonarqube8_9030_2
docker rm sonarqube8_9030_2
```

### Run Petstore App
* https://github.com/mybatis/jpetstore-6
  
```bash
cd ~/projects/master
git clone --depth=1 https://github.com/mybatis/jpetstore-6.git
cd ~/projects/master/jpetstore-6

mvn clean package -DskipTests

# running the sonar scan now
export projectKey=jpetstore-6

mvn org.jacoco:jacoco-maven-plugin:prepare-agent verify sonar:sonar \
    -Dsonar.host.url=http://localhost:9030 \
    -Dsonar.ws.timeout=300 \
    -Dmaven.test.failure.ignore=true \
    -Dsonar.projectKey=$projectKey -Dsonar.projectName=$projectKey

# you can see report here http://localhost:9030/projects

mvn cargo:run -P tomcat90
# Validate application in browser http://localhost:8080/jpetstore/
```