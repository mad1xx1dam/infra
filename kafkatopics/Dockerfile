FROM apache/kafka:3.9.0

ENTRYPOINT []

COPY topics.txt /etc/kafka/topics.txt

CMD /bin/bash -c "\
    echo 'Waiting for Kafka to be fully up...'; \
    while ! nc -z \$(echo \$KAFKA_BROKER | cut -d':' -f1) \$(echo \$KAFKA_BROKER | cut -d':' -f2); do sleep 2; done; \
    echo 'Kafka is up, now creating topics...'; \
    sed -i 's/[[:space:]]*\$//' /etc/kafka/topics.txt; \
    while IFS=':' read -r NAME PARTITIONS REPLICAS; do \
        echo 'Checking for topic: '\$NAME; \
        if /opt/kafka/bin/kafka-topics.sh --list --bootstrap-server \$KAFKA_BROKER | grep -wq \$NAME; then \
            echo 'Topic '\$NAME' already exists, skipping...'; \
        else \
            echo 'Creating topic '\$NAME' with '\$PARTITIONS' partitions and replication factor '\$REPLICAS'...'; \
            /opt/kafka/bin/kafka-topics.sh --create --bootstrap-server \$KAFKA_BROKER \
                --partitions \$PARTITIONS --replication-factor \$REPLICAS --topic \$NAME; \
        fi; \
    done < /etc/kafka/topics.txt; \
    echo 'All topics created.'"
