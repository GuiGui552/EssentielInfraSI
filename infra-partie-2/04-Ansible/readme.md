# Ansible
- Installation de Ansible
- Création d'un fichier inventaire en local sous le groupe ```targets```

- Test de la connexion ```ansible -i hosts.ini targets -m ping```

![alt text](<Capture d'écran 2026-01-13 153354.png>)

- Exécution du playbook ```ansible-playbook -i hosts.ini playbook.yml```

![alt text](image.png)

- Vérification avec ```curl localhost```

![alt text](image-1.png)

- Test de l'idempotence ```ansible-playbook -i hosts.ini playbook.yml```
    - Détection d'un changement

    ![alt text](image-2.png)

    - Relance sans modification

    ![alt text](image-3.png)