module Authenticatable
  extend ActiveSupport::Concern

  included do
    #
    # Devise
    #
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise :database_authenticatable,
          :registerable,
          :invitable,
          :recoverable,
          :rememberable,
          :validatable


    has_many :access_grants,
      class_name: 'Doorkeeper::AccessGrant',
      foreign_key: :resource_owner_id,
      dependent: :delete_all

    has_many :access_tokens,
      class_name: 'Doorkeeper::AccessToken',
      foreign_key: :resource_owner_id,
      dependent: :delete_all
  end
end
