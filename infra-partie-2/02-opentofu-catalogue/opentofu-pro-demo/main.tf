terraform {
    required_providers {
        docker = {
            source = "kreuzwerker/docker"
            version = "~> 3.0"
        }
    }
}

provider "docker" {}

# Réseau Docker dédié
resource "docker_network" "app_network" {
    name = "opentofu_network"
}

# Volumes pour PostgreSQL
resource "docker_volume" "postgres_data" {
    name = "postgres_data"
}

# Volumes pour Redis
resource "docker_volume" "redis_data" {
    name = "redis_data"
}


# Conteneur PostgreSQL
resource "docker_container" "postgres" {
    name = "postgres"
    image = "postgres:15"


    networks_advanced {
        name = docker_network.app_network.name
    }


    env = [
        "POSTGRES_DB=${var.db_name}",
        "POSTGRES_USER=${var.db_user}",
        "POSTGRES_PASSWORD=${var.db_password}"
    ]


    volumes {
        volume_name = docker_volume.postgres_data.name
        container_path = "/var/lib/postgresql/data"
    }
}

# Conteneur Redis
resource "docker_container" "redis" {
    name = "redis"
    image = "redis:7"


    networks_advanced {
        name = docker_network.app_network.name
    }


    volumes {
        volume_name = docker_volume.redis_data.name
        container_path = "/data"
    }
}

# Image Docker de l'API
resource "docker_image" "api_image" {
    name = "node-api:latest"


    build {
        context = "./api"
    }
}

# Conteneur API Node
resource "docker_container" "api" {
    name = "api"
    image = docker_image.api_image.name


    networks_advanced {
        name = docker_network.app_network.name
    }


    ports {
        internal = 3000
        external = var.api_port
    }


    env = [
        "DB_HOST=postgres",
        "DB_NAME=${var.db_name}",
        "DB_USER=${var.db_user}",
        "DB_PASSWORD=${var.db_password}",
        "REDIS_HOST=redis"
    ]


    # Dépendances : l’API démarre après PostgreSQL et Redis
    depends_on = [
        docker_container.postgres,
        docker_container.redis
    ]
}