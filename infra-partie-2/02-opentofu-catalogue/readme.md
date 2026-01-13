# Opentofu catalogue api
## Mise en place du projet
- configuration de l'infrastructure
    - réseau docker 
    - Volumes pour postgres et redis
    - Trois conteneurs pour redis, postgres et l'api (image docker pour l'api)  

- Création des variables ex: pour le port de l'api

```
variable "api_port" {
    description = "Port exposé pour l’API"
    type = number
    default = 3000
}
```


- initialisation des variables avec le fichier ```terraform.tfvars```

- Initialisation du projet
    - ```tofu init```
    - ```tofu plan```
    - ```tofu apply -auto-approve```

- Vérification avec ```docker ps```

![alt text](image.png)

- Test sur le navigateur 
    - Vérification si l'application fonctionne correctement (api, postgre et redis) ``` http://localhost:3000/health ```

    ![alt text](image-1.png)

   -  Vérifications des données ``` http://localhost:3000/products ```

   ![alt text](image-2.png)