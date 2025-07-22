+50
-0

require 'rails_helper'

RSpec.describe "Employees", type: :request do
  let(:admin) { create(:user, :admin) }
  let(:user) { create(:user) }
  let(:company) { create(:company) }

  describe "GET /employees" do
    it "allows admin to view index" do
      create(:employee, company: company, user: user)
      sign_in admin
      get employees_path
      expect(response).to have_http_status(:success)
    end

    it "redirects non-admin" do
      sign_in user
      get employees_path
      expect(response).to redirect_to(root_path)
    end
  end

  describe "CRUD" do
    before { sign_in admin }

    it "creates an employee" do
      expect {
        post employees_path, params: { employee: { name: 'New Emp', position: 'Dev', company_id: company.id, user_id: user.id } }
      }.to change(Employee, :count).by(1)
    end

    it "shows an employee" do
      employee = create(:employee, company: company, user: user)
      get employee_path(employee)
      expect(response).to have_http_status(:success)
    end

    it "updates an employee" do
      employee = create(:employee, company: company, user: user)
      patch employee_path(employee), params: { employee: { name: 'Updated' } }
      expect(employee.reload.name).to eq('Updated')
    end

    it "destroys an employee" do
      employee = create(:employee, company: company, user: user)
      delete employee_path(employee)
      expect(Employee.exists?(employee.id)).to be_falsey
    end
  end
end
