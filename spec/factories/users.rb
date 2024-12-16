FactoryBot.define do  # Définit une nouvelle factory avec FactoryBot
  factory :user do  # Crée une factory pour le modèle `User`
    sequence(:email) { |n| "user#{n}@example.com" }  # Génère un e-mail unique en utilisant un compteur `n` pour garantir l'unicité
    # Exemple : "user1@example.com", "user2@example.com", etc.
    password { "password" }  # Définit la valeur par défaut du mot de passe comme "password"
    password_confirmation { "password" }  # Définit la valeur par défaut de la confirmation du mot de passe pour être identique au mot de passe
  end
end
