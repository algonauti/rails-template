require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Respond to' do
    it { is_expected.to respond_to(:email) }
  end

  describe 'Associations' do
  end

  describe 'Validations' do
  end
end
