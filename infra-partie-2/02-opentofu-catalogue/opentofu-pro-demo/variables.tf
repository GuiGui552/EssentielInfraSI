variable "api_port" {
    description = "Port exposé pour l’API"
    type = number
    default = 3000
}


variable "db_name" {
    description = "Nom de la base PostgreSQL"
    type = string
}


variable "db_user" {
    description = "Utilisateur PostgreSQL"
    type = string
}


variable "db_password" {
    description = "Mot de passe PostgreSQL"
    type = string
    sensitive = true
}