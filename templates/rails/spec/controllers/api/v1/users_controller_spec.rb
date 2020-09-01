require "rails_helper"

RSpec.describe Api::V1::UsersController, type: :controller do
  before { doorkeeper_sign_in(user) }

  describe "GET #show" do
    context "when user exists" do
      let(:user) { create(:user) }

      it "returns own user" do
        get :show, params: { id: user.id }
        expect(response).to have_http_status(:ok)
      end
    end
  end

end
