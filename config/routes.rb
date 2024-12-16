Rails.application.routes.draw do
  resources :likes, only: [ :create, :destroy ]
  # Page "À propos"
  get "home/about"

  # Routes Devise pour l'authentification des utilisateurs
  devise_for :users, class_name: "User", path: "auth"

  # Ressources pour les utilisateurs (seulement la page de profil)
  resources :users

  # Ressources pour les posts
  resources :posts

  resources :posts do
    resources :comments, only: [ :create, :destroy ] # Crée des commentaires pour un post spécifique
  end

  # Route pour vérifier l'état de l'application
  get "up" => "rails/health#show", as: :rails_health_check

  # Définir la page d'accueil comme étant l'index des posts
  root "posts#index"
end
