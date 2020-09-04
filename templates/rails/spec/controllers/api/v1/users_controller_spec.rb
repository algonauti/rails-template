require "rails_helper"

RSpec.describe Api::V1::UsersController, type: :controller do
  before { doorkeeper_sign_in(user) }

  describe "GET #show" do
    context "when user exists" do
      let(:user) { create(:user) }

      it "returns own user" do
        get :show, params: { id: user.id }, format: :json

        expect(response).to have_http_status(:ok)
        expect(response_data).to have_id(user.id.to_s)
      end
    end
  end
end
