# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[google_oauth2]

  def self.from_omniauth(access_token)
    data = access_token['info']
    user = User.find_or_initialize_by(email: data['email']) do |u|
      u.name = data['name']
      u.password = Devise.friendly_token[0, 20]
    end
    user.save if user.new_record?
    user
  end
end
