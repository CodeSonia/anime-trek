class UserProfilePolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end
  def show?
    true # or any other condition to determine if the user can view the profile
  end

  def update?
    record.user == user
  end

  #def destroy?
    #record.user == user
  #end
end
