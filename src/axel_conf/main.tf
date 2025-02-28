terraform {
  required_providers {
    coder = {
      source = "coder/coder"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
  }
}

provider "coder" {}

provider "kubernetes" {
  config_path = "/etc/rancher/k3s/k3s.yaml"
}

variable "use_kubeconfig" {
  type    = bool
  default = false
}

variable "kubeconfig_path" {
  type    = string
  default = "~/.kube/config"
}

variable "namespace" {
  type        = string
  description = "The Kubernetes namespace to create workspaces in."

  validation {
    condition     = can(regex("^[a-z0-9]([-a-z0-9]*[a-z0-9])?$", var.namespace))
    error_message = "Le namespace doit être en minuscules et ne contenir que des lettres, chiffres et '-'."
  }
}

# 🚀 Namespace Kubernetes (création conditionnelle pour éviter les conflits)
resource "kubernetes_namespace" "coder" {
  count = length(data.kubernetes_namespace.coder) == 0 ? 1 : 0
  metadata {
    name = lower(var.namespace)
  }
}

data "kubernetes_namespace" "coder" {
  metadata {
    name = lower(var.namespace)
  }
}

data "coder_workspace" "me" {}
data "coder_workspace_owner" "me" {}

# Récupérer le PVC déjà existant
data "kubernetes_persistent_volume_claim" "home" {
  metadata {
    name      = "coder-testaxel-home"   # Nom du PVC créé manuellement
    namespace = "coder"                 # Namespace du PVC
  }
}

# Deployment avec initialisation du container et logging
resource "kubernetes_deployment" "main" {
  count      = data.coder_workspace.me.start_count
  depends_on = [data.kubernetes_persistent_volume_claim.home]  # Assurer que le PVC existe avant de créer le déploiement

  metadata {
    name      = "coder-${data.coder_workspace.me.id}"
    namespace = lower(var.namespace)
    labels = {
      app = "coder-${data.coder_workspace.me.id}"  # Ajout d'un label unique pour correspondre au selector
    }
  }

  spec {
    replicas = 1
    strategy {
      type = "Recreate"
    }

    selector {
      match_labels = {
        app = "coder-${data.coder_workspace.me.id}"  # Doit correspondre au label du pod
      }
    }

    template {
      metadata {
        labels = {
          app = "coder-${data.coder_workspace.me.id}"  # Doit correspondre au selector
        }
      }

      spec {
        security_context {
          run_as_user = 1000
          fs_group    = 1000
        }

        container {
          name              = "dev"
          image             = "codercom/enterprise-base:ubuntu"
          image_pull_policy = "Always"
          command           = ["sh", "-c", "while true; do sleep 30; done;"]
          security_context {
            run_as_user = 1000
          }
          volume_mount {
            mount_path = "/home/coder"
            name       = "home"
          }
        }

        init_container {
          name  = "init"
          image = "busybox"
          command = [
            "sh", "-c", "echo Initializing workspace logs > /home/coder/init.log"
          ]
          volume_mount {
            mount_path = "/home/coder"
            name       = "home"
          }
        }

        volume {
          name = "home"
          persistent_volume_claim {
            claim_name = data.kubernetes_persistent_volume_claim.home.metadata.0.name
          }
        }
      }
    }
  }
}

# ✅ Debugging : Vérifier le namespace utilisé
output "namespace_utilisé" {
  value = lower(var.namespace)
}
