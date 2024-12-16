# Instaclone - Clone d'Instagram avec Ruby on Rails

Instaclone est une application web construite avec Ruby on Rails (RoR) qui tente de recréer les fonctionnalités de base d'Instagram. Ce projet permet aux utilisateurs de partager des photos, de s'abonner à d'autres utilisateurs et de liker/commenter des publications.

## Fonctionnalités principales

- **Authentification des utilisateurs** : Inscription, connexion, et gestion de session.
- **Téléchargement de photos** : Les utilisateurs peuvent publier des photos depuis leur appareil.
- **Fil d'actualités** : Affichage des photos des utilisateurs suivis.
- **Abonnement** : Les utilisateurs peuvent s'abonner à d'autres profils et voir leurs publications dans leur fil d'actualités.
- **Likes et commentaires** : Les utilisateurs peuvent liker et commenter des publications.
- **Page de profil** : Chaque utilisateur possède une page de profil avec ses propres publications.

## Installation

1. **Cloner le repository** :

```bash
git clone https://github.com/ton-utilisateur/instaclone.git
cd instaclone
```

2. **Installer les dépendances** :

```bash
bundle install
```

3. **Configurer la base de données** :

```bash
rails db:create
rails db:migrate
rails db:seed # pour peupler la base de données avec des données initiales (facultatif)
```

4. **Lancer le serveur** :

```bash
rails server
```

Accédez à l'application via [http://localhost:3000](http://localhost:3000).

## Technologies utilisées

- **Ruby on Rails** : Framework backend
- **PostgreSQL** : Base de données relationnelle
- **Active Storage** : Pour la gestion des fichiers (photos)
- **Bootstrap** : Framework CSS pour le design
- **RSpec** : Pour les tests
- **Devise** : Pour l'authentification des utilisateurs

## Tests

1. **Exécuter les tests** :

```bash
rspec
```

Les tests sont situés dans le dossier `spec`.
