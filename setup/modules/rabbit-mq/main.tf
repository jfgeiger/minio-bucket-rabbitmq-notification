terraform {
  required_providers {
    rabbitmq = {
      source  = "cyrilgdn/rabbitmq"
      version = "~> 1.6.0"
    }
  }
}

provider "rabbitmq" {
  endpoint = "http://localhost:15672"
  username = "guest"
  password = "guest"
}

resource "rabbitmq_exchange" "test" {
  name  = "test"
  vhost = "/"

  settings {
    type        = "topic"
    durable     = true
    auto_delete = false
  }
}

resource "rabbitmq_queue" "test" {
  name  = "test"
  vhost = "/"

  settings {
    durable     = true
    auto_delete = false
  }
}

resource "rabbitmq_binding" "test" {
  source           = rabbitmq_exchange.test.name
  vhost            = "/"
  destination      = rabbitmq_queue.test.name
  destination_type = "queue"
  routing_key      = "bucket-key"
}