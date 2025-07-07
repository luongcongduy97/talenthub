class EmployeePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.has_role?(:admin)
        scope.all
      else
        scope.where(user: user)
      end
    end
  end

  def index?
    user.has_role?(:admin)
  end

  def show?
    user.has_role?(:admin) || record.user == user
  end

  def create?
    user.has_role?(:admin)
  end

  def update?
    user.has_role?(:admin)
  end

  def destroy?
    user.has_role?(:admin)
  end
end
