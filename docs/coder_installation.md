# Installation de Coder

Commande pour télécharger Coder

`curl -L https://coder.com/install.sh | sh`

Commande pour créer le namespace Coder

`sudo kubectl create namespace coder`

Normalement coder se lance automatiquement mais si ce n'est pas le cas

Vérifier si le service est lancé

`sudo systemctl status coder.service`

Si ce n'est pas le cas

`sudo systemctl start coder.servidce`

Et pour finir

`coder server`
