FROM apache/spark:3.5.8-java17-python3

# Create jars directory
RUN mkdir -p /opt/spark/jars

# Download Nessie jar
RUN curl -L -o /opt/spark/jars/nessie-spark-extensions-3.5_2.12-0.99.0.jar \
    https://repo1.maven.org/maven2/org/projectnessie/nessie-integrations/nessie-spark-extensions-3.5_2.12/0.99.0/nessie-spark-extensions-3.5_2.12-0.99.0.jar

# Download Iceberg runtime jar
RUN curl -L -o /opt/spark/jars/iceberg-spark-runtime-3.5_2.12-1.6.0.jar \
    https://repo1.maven.org/maven2/org/apache/iceberg/iceberg-spark-runtime-3.5_2.12/1.6.0/iceberg-spark-runtime-3.5_2.12-1.6.0.jar
RUN curl -L -o /opt/spark/jars/iceberg-aws-bundle-1.6.0.jar \
    https://repo1.maven.org/maven2/org/apache/iceberg/iceberg-aws-bundle/1.6.0/iceberg-aws-bundle-1.6.0.jar
