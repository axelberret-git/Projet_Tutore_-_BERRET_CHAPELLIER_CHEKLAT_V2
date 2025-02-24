# Installation de Coder

Commande pour installer coder

`sudo kubectl create namespace coder`

Normalement coder se lance automatiquement mais si ce n'est pas le cas :

Vérifier si le service est lancé :

`sudo systemctl status coder.service`

Si cen'est pas le cas :

`sudo systemctl start coder.servidce`

Et pour finir :

`coder server`
