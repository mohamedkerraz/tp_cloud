Documentation

for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do sudo apt-get remove $pkg; done


----> FIGMA Infrastructure schéma
https://www.figma.com/board/IUxIt5nHufFod4dwRb0Srr/TP-Cloud?node-id=0-1&t=aiGwi3S0dCPjuhW7-1


Documentation du Projet: Panorama du Cloud et Déploiement AWS
Introduction

Bonjour à toutes et à tous,


Objectifs du Projet

    Utilisation d'un projet existant : J'ai choisi un projet en [langage de programmation] que j'avais déjà réalisé.
    Séparation des fonctionnalités : Chaque fonctionnalité est séparée par conteneur ou instance (ex : HTTP, SCRIPT, DATA).
    Intégration des technologies : Le projet intègre le maximum des technologies vues ensemble durant le cours.
    Automatisation du déploiement : Utilisation des principes CI/CD et IaaC pour automatiser intégralement le déploiement de la plateforme.
    Documentation : Toutes les étapes réalisées sont documentées.
    Résilience aux pannes : La plateforme est conçue pour être résistante aux pannes.

Structure du Projet



TP_CLOUD [WSL: DEBIAN]
├── backend
├── database
│   └── postgres.compose.yml
├── frontend
├── infrastructure
│   ├── ansible
│   │   ├── .venv
│   │   ├── configs
│   │   │   ├── docker.playbook.yml
│   │   │   └── jenkins.playbook.yml
│   ├── prometheus
│   │   ├── config
│   │   │   └── prometheus.yml
│   │   └── volumes
│   │       ├── graph-prom.compose.yml
│   │       └── node_exporter
│   ├── terraform
│   │   ├── jenkins
│   │   │   └── terraform.yml
│   ├── .terraform.lock.hcl
│   ├── main.tf
│   ├── myKey.pem
│   ├── myKey.pub
│   ├── terraform.tfstate
│   ├── terraform.tfstate.backup
│   ├── variables.tf
│   ├── versions.tf
├── .env
├── .gitignore
├── docker.compose.yml
├── documentation.md
├── Jenkinsfile

Préparation du Projet
Création du Repository GitHub

    J'ai créé un repository GitHub pour le projet.
    Les branches principales main et develop ont été configurées.

Fichier .env

Le fichier .env à la racine du projet contient les clés ACCESS_KEY et SECRET_KEY nécessaires pour se connecter à mon compte AWS.
Conteneurisation avec Docker
Création des Dockerfiles

J'ai écrit des Dockerfiles pour chaque service de mon projet.
Définition des Réseaux et Volumes

Les réseaux et les volumes nécessaires pour les conteneurs sont définis.
Docker Compose

Le fichier docker-compose.yml orchestre les conteneurs localement. Voici un extrait du fichier :


Orchestration avec Docker Swarm
Initialisation du Réseau Swarm

J'ai utilisé Multipass pour créer un réseau Docker Swarm.
Déploiement des Services

Les services sont déployés sur le cluster Docker Swarm en utilisant des stacks Docker. Les services sont configurés pour être tolérants aux pannes (réplication, restart policies).
Déploiement sur AWS EC2
Préparation du Déploiement avec Terraform

Des scripts Terraform automatisent la création et la configuration des instances EC2, en utilisant le nom de clé SSH myKey.
Gestion de la Configuration avec Ansible

J'ai utilisé Ansible pour installer et configurer le nécessaire sur chaque instance EC2.
Monitoring avec Prometheus et Grafana
Exporters Prometheus

Les exporters Prometheus sont installés et configurés sur chaque instance pour surveiller les services.
Serveur Centralisé Prometheus

Un serveur Prometheus centralisé collecte les métriques de toutes les instances.
Visualisation avec Grafana

Grafana est installé et configuré pour la visualisation des métriques.
Automatisation avec Jenkins
Installation de Jenkins

Jenkins est installé sur une instance dédiée.
Configuration des Pipelines

Des pipelines CI/CD dans Jenkins automatisent le build, les tests et le déploiement de l'application. Voici un extrait du Jenkinsfile :

groovy

pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                sh 'echo "Building..."'
            }
        }
        stage('Test') {
            steps {
                sh 'echo "Testing..."'
            }
        }
        stage('Deploy') {
            steps {
                sh 'echo "Deploying..."'
            }
        }
    }
}












































