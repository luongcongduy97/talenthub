class CompanyPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      user.has_role?(:admin) ? scope.all : scope.none
    end
  end

  def index?
    user.has_role?(:admin)
  end

  def show?
    user.has_role?(:admin)
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
