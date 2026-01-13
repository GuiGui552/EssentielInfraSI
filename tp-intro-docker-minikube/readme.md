# Intro Docker Minikube

- Création des fichiers (server node.js, dockerfile)

- Build image docker ```docker build -t hello-node:1.0 .```

![alt text](image.png)

- Validation ```docker images```

![alt text](image-1.png)

- Lancement du conteneur ```docker run -d --name hello-node -p 8080:8080 hello-node:1.0```

- Validation ```docker ps```

![alt text](image-2.png)

```curl http://localhost:8080```

![alt text](image-3.png)

