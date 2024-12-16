require 'rails_helper'  # Charge toutes les configurations nécessaires pour exécuter les tests avec RSpec dans un environnement Rails.

RSpec.describe UsersController, type: :controller do  # Déclare le début des tests pour le contrôleur `UsersController`.

  # Création d'utilisateurs via FactoryBot
  let!(:user) { create(:user) }  # Crée un utilisateur fictif avant chaque test.
  let!(:other_user) { create(:user) }  # Crée un autre utilisateur fictif avant chaque test, utile pour tester les interactions avec plusieurs utilisateurs.

  before do
    # Simulation de l'authentification
    allow(controller).to receive(:authenticate_user!).and_return(true)  # Simule une authentification réussie, l'utilisateur est automatiquement connecté pour tous les tests.
    allow(controller).to receive(:current_user).and_return(user)  # Définit `current_user` comme étant l'utilisateur `user` pour les tests.
  end

  describe "GET #index" do  # Test pour l'action `index` du contrôleur `UsersController`.
    it "returns a success response and assigns all users" do  # Vérifie si l'action `index` renvoie une réponse réussie et assigne tous les utilisateurs.
      process :index, method: :get  # Remplace l'appel direct à `get` par `process`, qui envoie une requête `GET` à l'action `index`.
      expect(response).to be_successful  # Vérifie que la réponse est réussie (statut HTTP 200).
      expect(assigns(:users)).to match_array([user, other_user])  # Vérifie que la variable `@users` contient bien les deux utilisateurs créés (`user` et `other_user`).
    end
  end

  describe "GET #new" do  # Test pour l'action `new` du contrôleur `UsersController`.
    it "returns a success response and assigns a new user" do  # Vérifie si l'action `new` renvoie une réponse réussie et assigne un nouvel utilisateur.
      process :new, method: :get  # Envoie une requête `GET` à l'action `new`.
      expect(response).to be_successful  # Vérifie que la réponse est réussie (statut HTTP 200).
      expect(assigns(:user)).to be_a_new(User)  # Vérifie que la variable `@user` est bien un nouvel objet `User` non sauvegardé.
    end
  end

  describe "GET #show" do  # Test pour l'action `show` du contrôleur `UsersController`.
    it "returns a success response and assigns the correct user" do  # Vérifie que l'action `show` renvoie une réponse réussie et assigne le bon utilisateur.
      process :show, method: :get, params: { id: user.id }  # Envoie une requête `GET` à l'action `show` avec l'ID de `user`.
      expect(response).to be_successful  # Vérifie que la réponse est réussie (statut HTTP 200).
      expect(assigns(:user)).to eq(user)  # Vérifie que la variable `@user` correspond bien à l'utilisateur `user` que l'on a passé dans les paramètres.
    end

    it "returns 404 if the user is not found" do  # Test lorsque l'utilisateur demandé n'existe pas.
      expect {
        process :show, method: :get, params: { id: -1 }  # Envoie une requête `GET` avec un ID inexistant.
      }.to raise_error(ActiveRecord::RecordNotFound)  # Vérifie que l'on obtient bien une erreur `RecordNotFound`, ce qui déclenche une réponse 404.
    end
  end
end
