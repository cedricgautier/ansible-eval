# Variables
COMPOSE = docker compose

# Démarrer l’environnement
up:
	@echo " Demarrage environnement de travail..."
	@$(COMPOSE) build
	@$(COMPOSE) up -d

# Arrêter l’environnement
down:
	@echo "Arret environnement de travail..."
	@$(COMPOSE) down -v

ssha:
	@ssh -p 2222 -i ssh/connect-ansible root@localhost

# Redémarrer (arrêt + démarrage)
res: down up

# Afficher les logs
logs:
	@$(COMPOSE) logs -f

# Liste des conteneurs
list:
	@$(COMPOSE) ps

# Aide
help:
	@echo "Commandes disponibles :"
	@echo "  make start      Lancer environnement de travail"
	@echo "  make stop       Arreter environnement de travail"
	@echo "  make restart    Redemarrer environnement de travail"
	@echo "  make logs       Voir les logs environnement de travail"
	@echo "  make list       Voir les conteneurs actifs environnement de travail"
