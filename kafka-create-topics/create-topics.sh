#!/bin/bash

BROKER="localhost:9092"

echo "Kafka is up, creating topics..."

TOPICS=(
    "user-profile-viewed:3:1" # topicName:partitions:replicas
    "user-profile-viewed.DLT:1:1"
    "test:3:1"
)

for topic in "${TOPICS[@]}"; do
    IFS=":" read -r NAME PARTITIONS REPLICAS <<< "$topic"

    if /opt/kafka/bin/kafka-topics.sh --list --bootstrap-server "$BROKER" | grep -wq "$NAME"; then
        echo "Topic $NAME already exists, skipping..."
        continue
    fi

    echo "Creating topic $NAME at broker $BROKER ($PARTITIONS partitions, $REPLICAS replicas)..."

    if /opt/kafka/bin/kafka-topics.sh --create \
        --bootstrap-server "$BROKER" \
        --replication-factor "$REPLICAS" \
        --partitions "$PARTITIONS" \
        --topic "$NAME"; then
        echo "Topic $NAME created"
    else
        echo "Error creating $NAME"
    fi
done

echo "All topics created"