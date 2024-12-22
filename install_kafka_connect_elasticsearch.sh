docker run --rm \
     -v $(pwd)/kafka-connect-plugins:/usr/share/kafka/plugins \
     confluentinc/cp-kafka-connect:7.2.1 \
     confluent-hub install --no-prompt confluentinc/kafka-connect-elasticsearch:latest