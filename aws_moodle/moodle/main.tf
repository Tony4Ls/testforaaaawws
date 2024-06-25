resource "helm_release" "moodle" {
  name       = "moodle"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "moodle"
  namespace  = "default"

  set {
    name  = "moodleUsername"
    value = var.moodle_admin_user
  }

  set {
    name  = "moodlePassword"
    value = var.moodle_admin_password
  }

  set {
    name  = "moodleEmail"
    value = var.moodle_admin_email
  }

  set {
    name  = "mariadb.auth.rootPassword"
    value = var.mariadb_root_password
  }

  set {
    name  = "mariadb.auth.username"
    value = var.mariadb_user
  }

  set {
    name  = "mariadb.auth.password"
    value = var.mariadb_password
  }

  set {
    name  = "mariadb.auth.database"
    value = var.mariadb_database
  }

  set {
    name  = "service.type"
    value = "LoadBalancer"
  }

  set {
    name  = "persistence.enabled"
    value = "true"
  }

  set {
    name  = "persistence.size"
    value = "8Gi"
  }

  set {
    name  = "mariadb.primary.persistence.enabled"
    value = "true"
  }

  set {
    name  = "mariadb.primary.persistence.size"
    value = "8Gi"
  }
}
