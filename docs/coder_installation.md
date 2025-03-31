# Installation de Coder

Commande pour créer le namespace Coder et installer Coder

`sudo kubectl create namespace coder`

Normalement coder se lance automatiquement mais si ce n'est pas le cas il est possible d'effectuer cela :

Télécharger Coder

`curl -L https://coder.com/install.sh | sh`

Vérifier si le service est lancé

`sudo systemctl status coder.service`

Si ce n'est pas le cas

`sudo systemctl start coder.servidce`

Et pour finir

`coder server`
