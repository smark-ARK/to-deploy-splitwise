class StaticController < ApplicationController
  include FriendsConcern
  include ExpensesConcern

  
  def dashboard
    @friends = fetch_friends
    @expense = Expense.new
    @payment = Payment.new
    @stats = get_stats

  end

  def person
  end
end
