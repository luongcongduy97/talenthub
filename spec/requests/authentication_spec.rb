# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Authentication', type: :request do
  describe 'registration' do
    it 'allows user to register' do
      expect do
        post user_registration_path, params: {
          user: {
            email: 'newuser@example.com',
            password: 'password123',
            password_confirmation: 'password123'
          }
        }
      end.to change(User, :count).by(1)

      user = User.last
      expect(response).to redirect_to(user_path(user))
      follow_redirect!
      expect(response).to have_http_status(:success)
    end
  end

  describe 'login' do
    it 'allows user to login' do
      user = User.create!(email: 'login@example.com', password: 'password123', password_confirmation: 'password123')

      post user_session_path, params: { user: { email: user.email, password: 'password123' } }

      expect(response).to redirect_to(user_path(user))
      follow_redirect!
      expect(response).to have_http_status(:success)
    end
  end
end
