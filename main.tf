# Uses a production-grade, enterprise-ready chart from Bitnami
# https://artifacthub.io/packages/helm/bitnami/drupal
# https://docs.bitnami.com/kubernetes/apps/drupal/get-started/expose-service/


resource "helm_release" "drupal_dev" {
  name       = var.helm_app_name
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "drupal"
  #version    = ""
  #namespace = "production-ns"
  namespace = var.cluster_namespace
  create_namespace = var.create_namespace
  atomic          = var.atomic
  #cleanup_on_fail = true
  

  # MUST be false to connect to external database
  set {
    name  = "mariadb.enabled"
    value = var.mariadb_enabled
  }

  set {
    name  = "externalDatabase.port"
    value = "3306"
  }

  set {
    name  = "externalDatabase.host"
    value = var.externalDatabase_host
  }

  set {
    name  = "externalDatabase.user"
    value = var.externalDatabase_user
  }

  set {
    name  = "externalDatabase.password"
    value = var.externalDatabase_password
  }

  set {
    name  = "externalDatabase.database"
    value = var.externalDatabase_database
    #value = var.externaldbprod_database
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

  set {
    name  = "persistence.accesModes"
    value = "ReadWriteMany"
  }

  set {
    name  = "persistence.size"
    value = "10Gi"
  }

  #set {
  #  name  = "service.type"
  #  value = "clusterIP"
  #}

  set {
    name = "ingress.enabled"
    value = "true"
  }

  set {
    name  = "ingress.ingressClassName"
    value = "nginx"
  }

}
