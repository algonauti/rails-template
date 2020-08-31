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

  end
end
