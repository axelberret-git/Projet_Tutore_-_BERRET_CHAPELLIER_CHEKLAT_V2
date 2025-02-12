# Installation du cluster Kubernetes

## Mettre à jour 

`sudo apt update && sudo apt upgrade -y`

## Installastion de K3s

1. La méthode la plus simple pour installer k3s sur la machine est d'utiliser le script officel 

`curl -sfL https://get.k3s.io | sh -`

2. Verfier que kubernetes fonctionne 

`kubectl get nodes`


