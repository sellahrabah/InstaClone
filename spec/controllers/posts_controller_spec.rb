require 'rails_helper'  # Charge toutes les dépendances et configurations pour les tests avec RSpec dans Rails.

RSpec.describe PostsController, type: :controller do  # Déclare le début des tests pour le contrôleur `PostsController`.
  
  # Création d'utilisateurs et de posts via FactoryBot
  let!(:user) { create(:user) }  # Crée un utilisateur valide avant chaque test.
  let!(:post) { create(:post, user: user) }  # Crée un post associé à `user`.
  let!(:other_post) { create(:post) }  # Crée un autre post, sans lien avec `user`.
  let(:valid_attributes) { attributes_for(:post, user_id: user.id) }  # Définit des attributs valides pour un post.
  let(:invalid_attributes) { { title: nil, content: "" } }  # Définit des attributs invalides pour un post.

  before do
    # Simulation d'authentification
    allow(controller).to receive(:authenticate_user!).and_return(true)  # Simule une authentification réussie.
    allow(controller).to receive(:current_user).and_return(user)  # Simule que l'utilisateur actuel est `user`.
  end

  describe "POST #create" do  # Début de l'ensemble de tests pour l'action `create`.
    context "with valid parameters" do  # Test avec des paramètres valides.
      it "creates a new Post" do  # Vérifie qu'un post est créé avec des paramètres valides.
        expect {
          process :create, method: :post, params: { post: valid_attributes }
        }.to change(Post, :count).by(1)  # Vérifie que le nombre de posts augmente de 1.
      end

      it "redirects to the created post" do  # Vérifie la redirection après la création d'un post.
        process :create, method: :post, params: { post: valid_attributes }
        created_post = assigns(:post)  # Récupère le post créé.
        expect(response).to redirect_to(post_path(created_post))  # Vérifie que la redirection se fait vers le post créé.
        expect(flash[:notice]).to eq("Post was successfully created.")  # Vérifie le message flash de succès.
      end
    end

    context "with invalid parameters" do  # Test avec des paramètres invalides.
      it "does not create a new Post" do  # Vérifie qu'aucun post n'est créé avec des paramètres invalides.
        expect {
          process :create, method: :post, params: { post: invalid_attributes }
        }.not_to change(Post, :count)  # Vérifie que le nombre de posts ne change pas.
      end

      it "renders the new template with errors" do  # Vérifie la vue rendue après un envoi de formulaire invalide.
        process :create, method: :post, params: { post: invalid_attributes }
        expect(response).to render_template(:new)  # Vérifie que la vue `new` est rendue avec les erreurs.
      end
    end
  end
end
