# Adopte un Wouf

Application multiplateforme développée en Flutter dans le cadre d'un projet académique. Elle permet de consulter un catalogue exhaustif de races de chiens, de les rechercher et de sauvegarder ses favoris. 

L'application consomme les données JSON de [The Dog API](https://dogapi.dog/) (v2).

## ✨ Fonctionnalités Implémentées (Cahier des charges respecté)

- **Catalogue (API & UI)** : Récupération des données via HTTP, parsing JSON sécurisé et affichage des images avec cache et fallback.
- **Responsivité (Mobile & Tablette)** : 
  - Affichage en liste verticale (`ListView`) sur les écrans étroits (Mobile).
  - Bascule automatique en grille (`GridView`) sur les grands écrans (Tablette/Desktop) grâce à `MediaQuery`.
- **Détail & Navigation** : Navigation routée vers une page de détails complète au clic sur une carte.
- ** Fonctionnalités Supplémentaires (Bonus)** :
  - **Gestion d'état robuste** : Utilisation de **Riverpod** pour isoler la logique métier de l'interface graphique.
  - **Favoris persistants** : Mise en favoris d'une race avec sauvegarde locale via `shared_preferences`.
  - **Recherche globale instantanée** : Filtrage en mémoire sur l'ensemble de la base de données (sans perdre la vue paginée d'origine).
  - **Thème dynamique** : Bascule instantanée entre le mode clair et le mode sombre.

## 🛠️ Stack Technique & Dépendances

- **SDK** : Flutter & Dart
- **State Management** : `flutter_riverpod`
- **Routage** : `go_router`
- **Réseau** : `http`
- **Stockage local** : `shared_preferences`
- **Gestion des images** : `cached_network_image`

## Installation & Lancement

### 1. Prérequis
Assurez-vous d'avoir [Flutter](https://docs.flutter.dev/get-started/install) installé sur votre machine.

### 2. Cloner le projet et installer les dépendances
Ouvrez un terminal et exécutez les commandes suivantes :

```bash
# Cloner le dépôt
git clone https://github.com/Aistees/cross_platform_rendu
cd cross_platform_rendu

# Récupérer les paquets (dépendances)
flutter pub get

# Lancer l'application
flutter run

# pour lancer et eviter les erreur cors
flutter run -d chrome --web-browser-flag "--disable-web-security"

flutter run -d linux
# ou
flutter run -d windows

# Analyse de l'applcation
flutter analyze
