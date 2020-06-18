#!/usr/bin/env bash
# use EST/EDT as default Timezone
echo EST5EDT > /etc/timezone

copyJarsNow(){
    if [[ -d "/spark/spark-jars" ]]; then
        cp /spark/spark-jars/*.jar $SPARK_HOME/jars
    fi

	    if [[ ! -f "$ZEPPELIN_HOME/notebook-copied.txt" ]]; then
        	cp -R $ZEPPELIN_HOME/notebook-bak/* $ZEPPELIN_HOME/notebook
			touch $ZEPPELIN_HOME/notebook-copied.txt
    	fi

		if [[ ! -d "$ZEPPELIN_HOME/notebook" ]]; then
			mkdir $ZEPPELIN_HOME/notebook
        	cp -R $ZEPPELIN_HOME/notebook-bak/* $ZEPPELIN_HOME/notebook
			touch $ZEPPELIN_HOME/notebook-copied.txt
    	fi
}

if [[ -z "$@" ]]; then
	echo "starting zeppelin ..."
	copyJarsNow

	cd $ZEPPELIN_HOME
	./bin/zeppelin.sh start
else
    exec "$@"
fi

