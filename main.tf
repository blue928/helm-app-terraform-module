# Uses a production-grade, enterprise-ready chart from Bitnami
# https://artifacthub.io/packages/helm/bitnami/drupal
# https://docs.bitnami.com/kubernetes/apps/drupal/get-started/expose-service/


resource "helm_release" "drupal_dev" {
  name       = "drupal-test-test"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "drupal"
  #version    = ""
  namespace = "production-ns"
  #atomic          = true
  #cleanup_on_fail = true

  # MUST be false to connect to external database
  set {
    name  = "mariadb.enabled"
    value = var.auto_deploy_database
  }

  set {
    name  = "externalDatabase.port"
    value = "3306"
  }

  set {
    name  = "externalDatabase.host"
    value = var.externaldb_fqdn
    #value = "modulebaselift-fs-db-server.mysql.database.azure.com"
  }

  set {
    name  = "externalDatabase.user"
    value = var.externaldbprod_user
  }

  set {
    name  = "externalDatabase.password"
    value = var.externaldbprod_password
  }

  set {
    name  = "externalDatabase.database"
    value = var.externaldbprod_database
  }

  set {
    name  = "global.storageClass"
    value = "aks-file-share-custom-sc-csi"
  }

  set {
    name  = "drupalUsername"
    value = "drupaltest"
  }

  set {
    name  = "drupalPassword"
    value = "testdrupal"
  }

  #set {
  #  name = "persistence.accesModes"
  #  value = "ReadWriteMany"
  #}

  #set {
  #  name = "persistence.size"
  #  value = "10Gi"
  #}

}