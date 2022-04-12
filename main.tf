# Uses a production-grade, enterprise-ready chart from Bitnami
# https://artifacthub.io/packages/helm/bitnami/drupal
# https://docs.bitnami.com/kubernetes/apps/drupal/get-started/expose-service/
# for ingress: https://docs.bitnami.com/kubernetes/apps/drupal/configuration/configure-ingress/


# Note: helm_release follows all install conventions of helm, noteably, the
# --create-namespace flag does not delete the namespace it creates after uninstall. 
# For this to also be managed, it needs to be created with the kubernetes_namespace
# resource instead of the helm_release resource.
# See: https://github.com/hashicorp/terraform-provider-helm/issues/785

resource "kubernetes_namespace_v1" "app_namespace" {
  metadata {
    annotations = {}
    labels      = {}
    name        = "${var.helm_app_name}-ns"
  }
}


resource "helm_release" "drupal_dev" {
  name       = var.helm_app_name
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "drupal"
  #version    = ""
  namespace        = kubernetes_namespace_v1.app_namespace.metadata[0].name 
  atomic           = var.atomic
  timeout = var.timeout

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
    name  = "replicaCount"
    value = "2"
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
    name  = "persistence.accessModes[0]"
    value = "ReadWriteMany"
  }

  set {
    name  = "persistence.size"
    value = "10Gi"
  }

  #set {
  #  name  = "service.type"
  #  value = "ClusterIP"
  #}

  # Let's Encrypt or another certification method must already
  # be configured on the cluster for this to work.
  set {
    name  = "ingress.tls"
    value = "true"
  }

  set {
    name  = "ingress.enabled"
    value = "true"
  }

  set {
    name  = "ingress.ingressClassName"
    value = "nginx"
  }

  set {
    name = "ingress.annotations.cert-manager\\.io/cluster-issuer"
    value = "letsencrypt-prod"
  }

  set {
    name  = "ingress.hostname"
    value = var.ingress_hostname
  }

}