# README

* git clone 
* bundle install
* rake db:create
* rails db:migrate
* rails db:seed
* rails s



* ==>archivage automatique des messages de plus de 3 mois
l'archivage se fait automatique avant de lister les messages 
(before_action :archiver_message, only: [:index])


* ==>remplacement automatique des emails et numéro de téléphone contenus dans les messages par le mot « confidentiel »

cette action est faite au moment de la création du message
(before_action :set_message, only: [:create])

* lister les messages visibles par un destinataire par ordre chronologique

dans ce cas id=6 c'est bien l'id de l'utilisateur désormais connecté sur l'application

http://127.0.0.1:3000/api/v1/messages?id=6

* lister les messages visibles par fil de discussion (dans ce cas j'aurais seulement les fils de disscusion regroupant )

http://127.0.0.1:3000/api/v1/messages?id=6&group=fil
