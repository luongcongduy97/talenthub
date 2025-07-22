require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:admin) { create(:user, :admin) }
  let(:user) { create(:user) }

  describe "GET /users" do
    it "allows admin to view index" do
      sign_in admin
      get users_path
      expect(response).to have_http_status(:success)
    end

    it "redirects non-admin users" do
      sign_in user
      get users_path
      expect(response).to redirect_to(root_path)
    end
  end

  describe "GET /users/:id" do
    it "allows a user to view their own profile" do
      sign_in user
      get user_path(user)
      expect(response).to have_http_status(:success)
    end

    it "allows admin to view another user's profile" do
      sign_in admin
      get user_path(user)
      expect(response).to have_http_status(:success)
    end

    it "redirects unauthorized access" do
      other = create(:user)
      sign_in other
      get user_path(user)
      expect(response).to redirect_to(root_path)
    end
  end
end
