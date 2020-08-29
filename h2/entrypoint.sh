#!/usr/bin/env bash

TOUCH_FILE="/h2/h2server.created"

function startServer(){
    # if already not copied then only copy
    if [[ ! -f "${TOUCH_FILE}" ]]; then
        # echo 
        java -cp /h2.jar org.h2.tools.Shell -driver org.h2.Driver \
          -url "jdbc:h2:/h2/$DB_NAME" -user $DB_USER -password $DB_PWD \
          -sql "CREATE TABLE Startup(comment VARCHAR(255), created_at TIMESTAMP); INSERT INTO Startup VALUES('Created Database At', now());" >> ${TOUCH_FILE}
    fi
    echo "starting h2 server now ..."
    # echo 
    java -cp /h2.jar org.h2.tools.Shell -driver org.h2.Driver \
        -url "jdbc:h2:/h2/$DB_NAME" -user $DB_USER -password $DB_PWD \
        -sql "INSERT INTO Startup VALUES('Starting Database AT', now());"  >> ${TOUCH_FILE}

    echo "
    You can connect to DB using sql client at web app http://localhost:$WEB_PORT 
    or a jdbc app using following:
        Driver Class=org.h2.Driver 
        JDBC URL=jdbc:h2:tcp://localhost:$TCP_PORT//h2/$DB_NAME 
        User Name=$DB_USER 
        Password=$DB_PWD

        and execute \"select * from startup;\"
        "

    nohup sleep 5 && java -cp /h2.jar org.h2.tools.Shell -driver org.h2.Driver \
          -url "jdbc:h2:/h2/${DB_NAME};DB_CLOSE_ON_EXIT=FALSE" \
          -user $DB_USER -password $DB_PWD \
          -sql "select now() from dual;" >> /h2/nohup.log.txt 2>&1 &

    # echo starting 
    java -cp /h2.jar org.h2.tools.Server \
        -webPort $WEB_PORT -tcpPort $TCP_PORT -web -webAllowOthers -tcp -tcpAllowOthers
}

if [[ -z "$@" ]]; then
    startServer
else
    # echo "Starting WITH args"
    exec "$@"
fi
