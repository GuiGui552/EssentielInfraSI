# Minikube et kubectl
## Installation
- Pour Kubectl
    - ```sudo apt install -y snapd```
    - ```sudo snap install kubectl --classic```
    - Vérification avec ```kubectl version```  

    ![alt text](image.png)

- Pour Minikube
    - ```sudo mv minikube-linux-amd64 /usr/local/bin/minikube```  
    - Vérification avec ```minikube version```

    ![alt text](image-1.png)

# Démarrage
- On démarre minikube avec ```minikube start --driver=docker```  

![alt text](image-2.png)
- Vérification de l'état de minikube et kubectl
    - ```minikube status``` et ```kubectl get nodes```  

    ![alt text](image-3.png)

# Déploiement d'une application Nginx
- Déploiement avec ```kubectl create deployment nginx --image=nginx```  

![alt text](image-4.png)
- Vérification ```kubectl get deployments``` et ```kubectl get pods```  

![alt text](image-5.png)

# Exposition de l'application
- Exposer l'application a l'extérieur du cluster avec la commande ```kubectl expose deployment nginx --type=NodePort --port=80```  

![alt text](image-6.png)
- Vérification ```kubectl get services``` 

![alt text](image-7.png)
- Récupérer l'URL ```minikube service nginx --url``` ou ```minikube service list```

![alt text](image-8.png)
- Tester depuis la VM ```curl $(minikube service nginx --url)```

![alt text](image-9.png)

# Nettoyage (Suppression des ressources Nginx)
- Suppression avec ```kubectl delete service nginx``` et ```kubectl delete deployment nginx```

![alt text](image-10.png)