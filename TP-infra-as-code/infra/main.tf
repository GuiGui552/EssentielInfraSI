terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {}

# Réseau commun 
resource "docker_network" "webnet" {
    name = "webnet"
}

#  Serveurs PostgreSQL 
resource "docker_container" "db" {
    count = 2
    name  = "postgres_${count.index + 1}"
    image = "postgres:15"

    env = [
        "POSTGRES_USER=admin",
        "POSTGRES_PASSWORD=admin",
        "POSTGRES_DB=webdb"
    ]

    networks_advanced {
        name = docker_network.webnet.name
    }

    ports {
        internal = 5432
        external = 5432 + count.index
    }
}

# Serveurs Node.js 
resource "docker_container" "app" {
    count = 2
    name  = "nodeapp_${count.index + 1}"
    image = "node:18"

    volumes {
        host_path      = abspath("../app")
        container_path = "/app"
    }

    command = [
        "sh",
        "-c",
        "cd /app && npm install && node index.js"
    ]

    networks_advanced {
        name = docker_network.webnet.name
    }

    ports {
        internal = 3000
        external = 3000 + count.index
    }
}

#  Serveurs Nginx
resource "docker_container" "nginx" {
    count = 2
    name  = "nginx_${count.index + 1}"
    image = "nginx:latest"

    depends_on = [
        docker_container.app
    ]

    volumes {
        host_path      = abspath("../nginx/default.conf")
        container_path = "/etc/nginx/conf.d/default.conf"
    }

    ports {
        internal = 80
        external = 8080 + count.index
    }

    networks_advanced {
        name = docker_network.webnet.name
    }
}
