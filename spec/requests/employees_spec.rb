require 'rails_helper'

RSpec.describe 'Employees', type: :request do
  it 'allows admin to create an employee' do
    admin = User.create!(email: 'admin2@example.com', password: 'password123', password_confirmation: 'password123')
    admin.add_role(:admin)
    company = Company.create!(name: 'Acme', industry: 'Tech')
    user = User.create!(email: 'emp@example.com', password: 'password123', password_confirmation: 'password123')

    post user_session_path, params: { user: { email: admin.email, password: 'password123' } }

    expect do
      post employees_path, params: { employee: { name: 'Bob', position: 'Dev', company_id: company.id, user_id: user.id } }
    end.to change(Employee, :count).by(1)
  end
end
