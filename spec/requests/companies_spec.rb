require 'rails_helper'

RSpec.describe "Companies", type: :request do
  let(:admin) { create(:user, :admin) }
  let(:user) { create(:user) }

  describe "GET /companies" do
    it "allows admin to view index" do
      create(:company)
      sign_in admin
      get companies_path
      expect(response).to have_http_status(:success)
    end

    it "redirects non-admin" do
      sign_in user
      get companies_path
      expect(response).to redirect_to(root_path)
    end
  end

  describe "CRUD" do
    before { sign_in admin }

    it "creates a company" do
      expect {
        post companies_path, params: { company: { name: 'New Co', industry: 'Tech' } }
      }.to change(Company, :count).by(1)
    end

    it "shows a company" do
      company = create(:company)
      get company_path(company)
      expect(response).to have_http_status(:success)
    end

    it "updates a company" do
      company = create(:company)
      patch company_path(company), params: { company: { name: 'Updated' } }
      expect(company.reload.name).to eq('Updated')
    end

    it "destroys a company" do
      company = create(:company)
      delete company_path(company)
      expect(Company.exists?(company.id)).to be_falsey
    end
  end
end
