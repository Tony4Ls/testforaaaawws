resource "kubernetes_namespace" "moodle" {
  metadata {
    name = "moodle"
  }
}

resource "kubernetes_deployment" "moodle" {
  metadata {
    name = "moodle"
    namespace = kubernetes_namespace.moodle.metadata[0].name
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "moodle"
      }
    }

    template {
      metadata {
        labels = {
          app = "moodle"
        }
      }

      spec {
        container {
          name = "moodle"
          image = "bitnami/moodle:latest"

          ports {
            container_port = 80
          }

          env = [
            {
              name = "MOODLE_DATABASE_HOST"
              value_from = {
                secret_key_ref = {
                  name = "db-secrets"
                  key  = "host"
                }
              }
            },
            {
              name = "MOODLE_DATABASE_PORT_NUMBER"
              value_from = {
                secret_key_ref = {
                  name = "db-secrets"
                  key  = "port"
                }
              }
            },
            {
              name = "MOODLE_DATABASE_USER"
              value_from = {
                secret_key_ref = {
                  name = "db-secrets"
                  key  = "username"
                }
              }
            },
            {
              name = "MOODLE_DATABASE_NAME"
              value_from = {
                secret_key_ref = {
                  name = "db-secrets"
                  key  = "dbname"
                }
              }
            },
            {
              name = "MOODLE_DATABASE_PASSWORD"
              value_from = {
                secret_key_ref = {
                  name = "db-secrets"
                  key  = "password"
                }
              }
            },
            {
              name = "MOODLE_REDIS_HOST"
              value = aws_elasticache_cluster.redis.cache_nodes[0].address
            },
            {
              name = "MOODLE_REDIS_PORT"
              value = aws_elasticache_cluster.redis.port
            }
          ]
        }
      }
    }
  }
}

resource "kubernetes_service" "moodle" {
  metadata {
    name = "moodle"
    namespace = kubernetes_namespace.moodle.metadata[0].name
  }

  spec {
    selector = {
      app = "moodle"
    }

    ports {
      port = 80
      target_port = 80
    }

    type = "NodePort"
  }
}

resource "kubernetes_ingress" "moodle" {
  metadata {
    name = "moodle"
    namespace = kubernetes_namespace.moodle.metadata[0].name
    annotations = {
      "kubernetes.io/ingress.class" = "alb"
      "alb.ingress.kubernetes.io/scheme" = "internal"
    }
  }

  spec {
    rule {
      http {
        path {
          path = "/"
          backend {
            service {
              name = kubernetes_service.moodle.metadata[0].name
              port {
                number = 80
              }
            }
          }
        }
      }
    }
  }
}
