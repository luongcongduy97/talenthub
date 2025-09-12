require 'rails_helper'

RSpec.describe Employee, type: :model do
  describe '.search_by_name_and_position' do
    it 'finds employees matching query within the scope' do
      company = create(:company)
      user    = create(:user)

      matching = create(:employee,
        name: 'Alice Developer', position: 'Engineer',
        company: company, user: user
      )

      # noise in same DB but different scope
      other_company = create(:company)
      create(:employee, name: 'Alice', position: 'Developer',
        company: other_company, user: user)

      create(:employee, name: 'Bob Manager', position: 'Manager',
        company: company, user: user)

      results = Employee.where(company: company, user: user)
                        .search_by_name_and_position('Alice')

      expect(results).to contain_exactly(matching)
    end
  end
end
