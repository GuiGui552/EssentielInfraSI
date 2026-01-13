# OpenTofu
## Installation sur windows
- Installation avec ```winget install --exact --id=OpenTofu.Tofu```
- Vérification ```tofu -version```

![alt text](image.png)

## Création du projet
- créer le fichier ```main.tf``` avec le contenu suivant:

![alt text](image-1.png)

## Initialisation du projet
- télécharger le provider docker ```tofu init```

![alt text](image-2.png)

- Simuler la création et lancement du déploiement ```tofu plan``` et ```tofu apply -auto-approve```

![alt text](image-3.png)

![alt text](image-4.png)

- Vérification avec ```docker ps```

![alt text](image-5.png)

- Détruire l’infrastructure ```tofu destroy -auto-approve```

![alt text](image-6.png)