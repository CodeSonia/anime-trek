class AnimePolicy < ApplicationPolicy
  class Scope < Scope

   def resolve
     scope.all
   end
  end

  def add_to_watchlist?
    user.present?
  end

  def current_user
    user
  end

  def index?
    true
  end

  def show?
    true
  end
end
