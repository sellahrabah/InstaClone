class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


         after_create :send_welcome_email

         def send_welcome_email
           UserMailer.welcome_email(self).deliver_later
         end


         has_many :posts
          has_many :comments
          has_many :likes
end
