#!/bin/sh
function read_message {
  curl -w "\n" -u guest:guest \
      -H "content-type:application/json" \
      --data '{"count":1, "requeue":false, "encoding":"auto", "ackmode":"ack_requeue_false"}' \
      http://localhost:15672/api/queues/%2f/test/get
}

echo "Before: "
read_message

echo "Move file to bucket..."
cat <<EOF | docker exec --interactive minio-bucket-rabbitmq-notification_minio_1 /bin/bash
touch file
mc cp file minio/test
EOF
echo "Moved file to bucket."

echo "After: "
read_message