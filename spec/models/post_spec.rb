require 'rails_helper'

RSpec.describe Post, type: :model do
  # Test de validation de présence et de longueur pour le titre
  it "is valid with a valid title, description, and keyword" do
    user = create(:user)  # Utilisez FactoryBot pour créer un utilisateur
    post = Post.new(title: "Valid Title", description: "Valid Description", keyword: "keyword", user: user)
    expect(post).to be_valid
  end

  it "is invalid without a title" do
    post = Post.new(description: "Valid Description", keyword: "keyword")
    expect(post).to_not be_valid
  end

  it "is invalid with a title shorter than 5 characters" do
    user = create(:user)
    post = Post.new(title: "abc", description: "Valid Description", keyword: "keyword", user: user)
    expect(post).to_not be_valid
  end

  it "is invalid with a title longer than 100 characters" do
    user = create(:user)
    long_title = "a" * 101
    post = Post.new(title: long_title, description: "Valid Description", keyword: "keyword", user: user)
    expect(post).to_not be_valid
  end

  # Test pour les autres attributs : description et keyword
  it "is invalid without a description" do
    user = create(:user)
    post = Post.new(title: "Valid Title", keyword: "keyword", user: user)
    expect(post).to_not be_valid
  end

  it "is invalid with a description longer than 100 characters" do
    user = create(:user)
    long_description = "a" * 101
    post = Post.new(title: "Valid Title", description: long_description, keyword: "keyword", user: user)
    expect(post).to_not be_valid
  end

  it "is invalid without a keyword" do
    user = create(:user)
    post = Post.new(title: "Valid Title", description: "Valid Description", user: user)
    expect(post).to_not be_valid
  end

  it "is invalid with a keyword longer than 100 characters" do
    user = create(:user)
    long_keyword = "a" * 101
    post = Post.new(title: "Valid Title", description: "Valid Description", keyword: long_keyword, user: user)
    expect(post).to_not be_valid
  end

  # Test de l'association belongs_to :user
  it { should belong_to(:user) }

  # Test de l'association has_many_attached :images
  it { should have_many_attached(:images) }

  # Test de la génération d'un id aléatoire avant la création
  it "randomizes the id before creation" do
    user = create(:user)
    post = Post.new(title: "Valid Title", description: "Valid Description", keyword: "keyword", user: user)

    # Test si un id aléatoire est généré
    post.save
    expect(post.id).not_to be_nil

    # Test pour vérifier qu'un id aléatoire valide est généré
    another_post = Post.new(title: "Another Valid Title", description: "Valid Description", keyword: "keyword", user: user)
    another_post.save
    expect(another_post.id).not_to eq(post.id)
  end

  # Test de l'attachement d'images
  it "can attach images" do
    user = create(:user)
    post = Post.new(title: "Valid Title", description: "Valid Description", keyword: "keyword", user: user)

    # Ajouter une image
    post.images.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'image.png')), filename: 'image.png', content_type: 'image/png')

    expect(post.images.attached?).to be_truthy
  end
end

RSpec.describe User, type: :model do
  # Test de l'association has_many :posts
  it { should have_many(:posts) }
end
