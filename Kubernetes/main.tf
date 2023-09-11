terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.18.1"
    }
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_deployment" "web_page" {
  metadata {
    name = "webpage"
    labels = {
      test = "webpage"
    }
  }

  spec {
    replicas = 3

    selector {
      match_labels = {
        test = "webpage"
      }
    }

    template {
      metadata {
        labels = {
          test = "webpage"
        }
      }

      spec {
        container {
          image = "fabricioveronez/web-page:blue"
          name  = "web-page"

        }
      }
    }
  }
}

resource "kubernetes_service" "web-page-service" {
  metadata {
    name = "webpage"
  }
  spec {
    selector = {
      test = "webpage"
    }
    port {
      port        = 8080
      target_port = 80
    }

    type = "ClusterIP"
  }
}

resource "kubernetes_ingress_v1" "webpage-ingress" {
  metadata {
    name = "webpage"
  }

  spec {
    ingress_class_name = "nginx"
    default_backend {
      service {
        name = "web-page-service"
        port {
          number = 80
        }
      }
    }

    rule {
      host = "web.1.2.3.4.nip.io"
      http {
        path {
          backend {
            service {
              name = "web_page_service"
              port {
                number = 8080
              }
            }
          }

          path = "/app1/*"
        }
      }
    }
  }
}
