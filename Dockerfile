FROM openjdk:8-jdk-slim

# Install Python and dependencies

RUN apt-get update && apt-get install -y python3 python3-pip curl

# Install Jupyter and PySpark 
RUN pip3 install jupyter findspark

# Set up environment variables

ENV JAVA_HOME /usr/local/openjdk-8 
ENV SPARK_HOME /usr/local/spark
ENV PATH $PATH:${SPARK_HOME}/bin

#Download and extract Spark

RUN curl https://archive.apache.org/dist/spark/spark-3.2.1/spark-3.2.1-bin-hadoop3.2.tgz | tar -xz -C /usr/local/
RUN ln -s /usr/local/spark-3.2.1-bin-hadoop3.2 $(SPARK_HOME)

#Set up PySpark kernel

RUN mkdir /usr/local/spark-3.2.1-bin-hadoop3.2/jars -p
RUN curl -s https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-ms/3.2.0/hadoop-ames-3.2.0.jar -o /usr/local/spark-3.2.1-bin-hadoop3.2/jars/hadoop-aws-3.2.0.jar 
RUN curl -s https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk/1.11.955/aws-java-sdk-1.11.955.jar -o /usr/local/spark-3.2.1-bin-hadoop3.2/jars/aws-java-sdk-1.11.955.jar
RUN curl -s https://repo1.maven.org/maven2/com/google/guava/guava/30.1.1-jre/guava-30.1.1-jre.jar -o /usr/local/spark-3.2.1-bin-hadoop3.2/jars/guava-30.1.1-jre.jar
RUN curl -s https://repo1.maven.org/maven2/org/apache/httpcomponents/httpclient/4.5.13/httpclient-4.5.13.jar -o /usr/local/spark-3.2.1-bin-hadoop3.2/jars/httpclient-4.5.1.jar 
RUN curl -s https://repo1.maven.org/maven2/org/apache/httpcomponents/httpcore/4.4.14/httpcore-4.4.14.jar -o /usr/local/spark-3.2.1-bin-hadoop3.2/jars/httpcore-4.4.14.jar
RUN curl -s https://repo1.maven.org/maven2/org/apache/commons/commons-lang3/3.13/commons-Lang3-3.13.jar -o /usr/local/spark-3.2.1-bin-hadoop3.2/jars/commons-lang3-3.13.jar

# Install JDBC driver for MySQL

RUN curl -s https://repo1.maven.org/maven2/mysql/mysql-connector-java/8.0.28/mysql-connector-java-8.0.28.jar -o /usr/local/spark-3.2.1-bin-hadoop3.2/jars/mysql-connector-java-8.0.28.jar

#Expose Jupyter notebook port
EXPOSE 8888

#Start Jupyter notebook server
CMD jupyter notebook --ip=0.0.0.0 --port=8888 --no-browser --allow-root
