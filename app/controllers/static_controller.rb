class StaticController < ApplicationController
  include FriendsConcern
  include ExpensesConcern

  
  def dashboard
    @friends = fetch_friends
    @expense = Expense.new

  end

  def person
  end
end
