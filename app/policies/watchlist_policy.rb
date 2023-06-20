class WatchlistPolicy < ApplicationPolicy

  def destroy?
    record.user == user
  end
end
