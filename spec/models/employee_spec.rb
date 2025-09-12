require 'rails_helper'

RSpec.describe Employee, type: :model do
  describe '.search_by_name_and_position' do
    it 'finds employees matching query' do
      company = create(:company)
      user = create(:user)
      matching = create(:employee, name: 'Alice Developer', position: 'Engineer', company: company, user: user)
      create(:employee, name: 'Bob Manager', position: 'Manager', company: company, user: user)
      results = Employee.search_by_name_and_position('Alice')
      expect(results).to contain_exactly(matching)
    end
  end
end
