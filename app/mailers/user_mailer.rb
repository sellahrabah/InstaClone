class UserMailer < ApplicationMailer
  default from: "rabahsella@gmail.com"

  def welcome_email(user)
    @url  = "http://localhost:3000/login"
    mail(to: @user.email, subject: "Bienvenue sur Instaclone !")
  end

  def notification_email(user, action)
    @user = user
    @action = action # Exemple : "un utilisateur a aimé votre post" ou "vous avez reçu un commentaire"
    mail(to: @user.email, subject: "Vous avez une nouvelle notification")
  end
end
