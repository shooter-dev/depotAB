include config.mk

.PHONY: all clone remotes fetch merge push clean

all: clone remotes fetch merge push

clone:
	@echo "📦 Clonage de $(DEPOT_AB) dans $(WORKDIR)"
	rm -rf $(WORKDIR)
	git clone $(DEPOT_AB) $(WORKDIR)

remotes:
	@echo "🔗 Ajout des dépôts distants A et B"
	cd $(WORKDIR) && git remote add depotA $(DEPOT_A)
	cd $(WORKDIR) && git remote add depotB $(DEPOT_B)

fetch:
	@echo "📥 Récupération des branches de depotA et depotB"
	cd $(WORKDIR) && git fetch depotA
	cd $(WORKDIR) && git fetch depotB

merge:
	@echo "🔀 Fusion de depotA/master et depotB/master dans $(FUSION_BRANCH)"
	cd $(WORKDIR) && git checkout -b $(FUSION_BRANCH) depotA/master
	cd $(WORKDIR) && git merge depotB/master || echo "⚠️ Résous les conflits manuellement"

push:
	@echo "🚀 Poussée vers $(DEPOT_AB)"
	git push origin $(FUSION_BRANCH)

clean:
	@echo "🧹 Nettoyage du dossier de travail"
	rm -rf $(WORKDIR)
