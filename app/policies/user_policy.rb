class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.has_role?(:admin)
        scope.all
      else
        scope.where(id: user.id)
      end
    end
  end

  def index?
    user.has_role?(:admin)
  end

  def show?
    user.has_role?(:admin) || record == user
  end
end
