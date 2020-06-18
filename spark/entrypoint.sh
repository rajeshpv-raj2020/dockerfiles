#!/usr/bin/env bash

copyJarsNow(){
    if [[ -d "/spark/spark-jars" ]]; then
        cp /spark/spark-jars/*.jar $SPARK_HOME/jars
    fi

    if [[ -d "/spark/app-jars" ]]; then
        cp /spark/app-jars/*.jar $SPARK_HOME/jars
    fi
}

startSpark(){
    cd ${SPARK_HOME}

    if [[ -z "$SPARK_MASTER_HOSTIP" ]]; then
         echo "STARTING... Spark as MASTER"
        ./sbin/start-master.sh --host 0.0.0.0 > /spark-started.out

        echo "Starting nohup browser app ...."
        nohup java -jar /BrowseHere.jar 3040 / &
    else 
        echo "STARTING... Spark as WORKER"
        export SPARK_LOCAL_IP=0.0.0.0
        ./sbin/start-slave.sh spark://${SPARK_MASTER_HOSTIP}:7077 > /spark-started.out
    fi 
}

createEnvFile(){
    echo "CREATING... spark-env.sh"

    echo "#!/usr/bin/env bash" > ${SPARK_HOME}/conf/spark-env.sh
    echo "SPARK_MASTER_PORT=7077" >> ${SPARK_HOME}/conf/spark-env.sh
    echo "SPARK_MASTER_WEBUI_PORT=8077" >> ${SPARK_HOME}/conf/spark-env.sh
    echo "SPARK_WORKER_CORES=${SPARK_WORKER_CORES:-4}" >> ${SPARK_HOME}/conf/spark-env.sh
    echo "SPARK_WORKER_MEMORY=${SPARK_WORKER_MEMORY:-2G}" >> ${SPARK_HOME}/conf/spark-env.sh
    echo "SPARK_WORKER_INSTANCES=${SPARK_WORKER_INSTANCES:-2}" >> ${SPARK_HOME}/conf/spark-env.sh
    echo "SPARK_WORKER_WEBUI_PORT=${SPARK_WORKER_WEBUI_PORT:-8051}" >> ${SPARK_HOME}/conf/spark-env.sh

    chmod u+x ${SPARK_HOME}/conf/spark-env.sh
}

tailLogFile(){
    if [[ -f "/spark-started.out" ]]; then
        VAR_ABS_LOG_PATH=$(sed -e 's/.*logging to \(.*\)\.out.*/\1/' /spark-started.out | head -n 1).out
        
        if [[ -f "$VAR_ABS_LOG_PATH" ]]; then
            tail -f $VAR_ABS_LOG_PATH
        fi
    else
        tail -f ${SPARK_HOME}/conf/spark-env.sh
    fi
}

# first if
if [[ -z "$@" ]]; then
    #  second if
    if [[ ! -f "${SPARK_HOME}/conf/spark-env.sh" ]]; then
        createEnvFile
    fi

    copyJarsNow
    startSpark


    tailLogFile
else
    exec "$@"
fi
