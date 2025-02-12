# Mettre en place gitpod sur kubernetes

## Prérequis 

1. Avoir un cluster kubernetes (cf. cluster_kubernetes_installation.md)

2. Avoir cert-manager installé sur le cluster 

Pour vérifier si cert-manager est présent, utilisez la commande :

`kubectl get namespaces`

Et si il est installé vous le verrais apparaitre :

```
NAME              STATUS   AGE
cert-manager      Active   18h
default           Active   20h
kube-system       Active   20h
```

Sinon il vous faudra l'installer : 

```
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.9.1/cert-manager.yaml
kubectl get pods --namespace cert-manager
```

## Installer KOTS 

KOTS simplifie l'installation de Gitpod sur Kubernetes.

`curl https://kots.io/install | bash`

## Installation de gitpod 

Maintenant nous pouvons installer le gidpod sur le kubernetes

1. Lancer l'installation de Gitpod :

`kubectl kots install gitpod`

2. Créer le namespace (par défaut : default) :

`kubectl kots admin-console --namespace default`