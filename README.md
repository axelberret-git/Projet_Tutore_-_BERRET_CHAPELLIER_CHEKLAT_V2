# Implémentation d'un Codespace auto-hébergé

Voici le README du projet tutoré traitant de l'implémentation d'un Codespace auto-hébergé.
Il servira de journal d'utilisation tout en retraçant le chemin parcouru pour la mise en 
place du système en allant du plan d'action élaboré (final) en passant par les problèmes
rencontrés.

Il sera notamment possible de consulter les sources qui nous ont permis l'élaboration ainsi
que la mise en place du projet du projet.


## Utilisation du Codespace - Gitpod




## Plan d'action

1. Installer un cluster Kubernetes sur le serveur dédié (k3s)
2. Déployer Gitpod avec Helm (pile LAMP)
3. Intégrer un stockage persistant pour les données des utilisateurs
4. Intégrer docker dans gitpod
5. Configurer l'ingress et la gestion des domaines pour accéder aux workspaces
6. Tester et ajuster les performances (scalabilité, auto-scaling)


## Problèmes rencontrés

1. Problème d'accès à l'admin console KOTS

- Explication du problème

Nous avions rencontré un problème lié à l'accès de l'admin console KOTS sur le réseau de la salle.
Pour résumer, le service n'écouter uniquement que sur "localhost" en témoigne le bind sur le port "8800"
(vérifiable avec `ss -tlnp | grep 8800`) avec l'ip "127.0.0.1".

- Solution

On a une solution qui consiste à bind sur l'ip 0.0.0.0 afin qu'elle donne l'accès à toutes les adresses
externes, or un problème de sécurité peut intervenir c'est pourquoi il faut réduire par des règles l'accès.
On limite alors l'accès uniquement aux adresses de format "100.64.85.0/24".

Les commandes effectuées sont consultables dans le fichier `gitpod_kubernetes_integration.md` de la documentation
du projet.


2. ...


## Sources

- Cluster Kubernetes : https://bobcares.com/blog/kubernetes-cluster-deployment-on-proxmox-8/
- Video cluster Kubernetes : https://www.youtube.com/watch?v=PtQ8FOepn94
- Projet référence de vérification d'installation Docker : https://github.com/docker/awesome-compose
- Comment créer un manifest Kubernetes : https://spacelift.io/blog/kubernetes-manifest-file
