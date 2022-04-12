#!/bin/bash
terraform -chdir=setup init
terraform -chdir=setup apply -auto-approve

cat <<EOF | docker exec --interactive minio-bucket-rabbitmq-notification_minio_1 /bin/bash
mc alias set minio http://localhost:9000 admin password
mc admin config set minio notify_amqp:_ exchange="test" exchange_type="topic" url="\$MINIO_NOTIFY_AMQP_URL" auto_deleted=false durable=on routing_key="bucket-key"
mc admin service restart minio
mc mb minio/test
mc event add minio/test arn:minio:sqs::_:amqp
EOF