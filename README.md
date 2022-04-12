# Run

```
docker-compose up
bash setup.sh
```

# Demo

```
bash file.sh
```

The script first requests messages from RabbitMQ and the response is empty, then puts a file into
the MinIo bucket and requests messages from RabbitMQ again, this time receiving the message caused
by the notification.

# Cleanup

```
bash destroy.sh
docker-compose down
```