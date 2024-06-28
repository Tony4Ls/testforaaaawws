resource "aws_ebs_volume" "moodle_pv" {
  count             = 2
  availability_zone = element(data.aws_availability_zones.available.names, count.index)
  size              = 20
  tags = {
    Name = "moodle-pv-${count.index}"
  }
}

resource "kubernetes_persistent_volume" "moodle_pv" {
  count = 2
  metadata {
    name = "moodle-pv-${count.index}"
  }
  spec {
    capacity = {
      storage = "20Gi"
    }
    access_modes = ["ReadWriteOnce"]
    persistent_volume_source {
      aws_elastic_block_store {
        volume_id = element(aws_ebs_volume.moodle_pv[*].id, count.index)
        fs_type   = "ext4"
      }
    }
  }
}

resource "kubernetes_persistent_volume_claim" "moodle_pvc" {
  metadata {
    name = "moodle-pvc"
  }
  spec {
    access_modes = ["ReadWriteOnce"]
    resources {
      requests = {
        storage = "20Gi"
      }
    }
  }
}

resource "kubernetes_deployment" "moodle" {
  metadata {
    name = "moodle"
    labels = {
      app = "moodle"
    }
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
          name  = "moodle"
          image = "bitnami/moodle:latest"
          port {
            name           = "http"
            container_port = 8080
          }
          port {
            name           = "https"
            container_port = 8443
          }
          env {
            name  = "ALLOW_EMPTY_PASSWORD"
            value = "yes"
          }
          env {
            name  = "MOODLE_DATABASE_USER"
            value = var.rds_master_username
          }
          env {
            name  = "MOODLE_DATABASE_PASSWORD"
            value = var.rds_master_password
          }
          env {
            name  = "MOODLE_DATABASE_NAME"
            value = var.rds_database_name
          }
          env {
            name  = "MOODLE_DATABASE_HOST"
            value = module.rds.rds_endpoint
          }
          volume_mount {
            name       = "moodle-storage"
            mount_path = "/bitnami/moodle"
          }
        }
        volume {
          name = "moodle-storage"
          persistent_volume_claim {
            claim_name = "moodle-pvc"
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "moodle" {
  metadata {
    name = "moodle"
  }
  spec {
    type = "LoadBalancer"
    port {
      name       = "http"
      port       = 80
      target_port = 8080
    }
    port {
      name       = "https"
      port       = 443
      target_port = 8443
    }
    selector = {
      app = "moodle"
    }
  }
}
