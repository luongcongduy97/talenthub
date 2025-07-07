require 'rails_helper'

RSpec.describe 'Companies', type: :request do
  it 'allows admin to create a company' do
    admin = User.create!(email: 'admin@example.com', password: 'password123', password_confirmation: 'password123')
    admin.add_role(:admin)

    post user_session_path, params: { user: { email: admin.email, password: 'password123' } }

    expect do
      post companies_path, params: { company: { name: 'Acme', industry: 'Tech' } }
    end.to change(Company, :count).by(1)
  end
end
