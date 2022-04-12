#!/bin/bash
terraform -chdir=setup destroy -auto-approve

rm -rf setup/.terraform
rm setup/.terraform.lock.hcl setup/terraform.tfstate setup/terraform.tfstate.backup

cat <<EOF | docker exec --interactive minio-bucket-rabbitmq-notification_minio_1 /bin/bash
mc rb  --dangerous --force minio
EOF