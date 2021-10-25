class Member < ApplicationRecord
    devise :omniauthable, omniauth_providers: [:google_oauth2]
    has_and_belongs_to_many :events

    def self.from_google(uid:, full_name:, email:)
      unless Whitelist.find_by(email: email) != nil
        return nil
      end
      create_with(uid: uid, name: full_name, email: email, isAdmin: Whitelist.find_by(email: email).isAdmin).find_or_create_by!(uid: uid)
    end
  
  end

