terraform {
  required_providers {
    docker = {
        source  = "kreuzwerker/docker"
    }
  }
}

provider "docker" {}

resource "docker_network" "webnet" {
    name = "webnet"
}

resource "docker_container" "db" {
    name  = "postgres"
    image = "postgres:15"

    env = [
        "POSTGRES_USER=admin",
        "POSTGRES_PASSWORD=admin",
        "POSTGRES_DB=webdb"
    ]

    networks_advanced {
        name = docker_network.webnet.name
    }
}

resource "docker_container" "app" {
    name  = "nodeapp"
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
        external = 3000
    }
}

resource "docker_container" "nginx" {
    name  = "nginx"
    image = "nginx:latest"

    volumes {
        host_path      = abspath("../nginx/default.conf")
        container_path = "/etc/nginx/conf.d/default.conf"
    }

    ports {
        internal = 80
        external = 8080
    }

    networks_advanced {
        name = docker_network.webnet.name
    }
}
