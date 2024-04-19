class StaticController < ApplicationController
  include FriendsConcern
  include ExpensesConcern

  
  def dashboard
    @friends = fetch_friends
    @expense = Expense.new
    @payment = Payment.new
    @friendship = Friendship.new 
    @stats = get_stats
    @users = User.where.not(id: @friends.pluck(:id)<<current_user.id)

  end

  def person
    @friends = fetch_friends
    @user = User.find(params[:id])
    @expenses = @user.splits.joins(:expenses, :users).paginate(page: params[:splits_page], per_page: 10)
    # @payments = @user.payments.paginate(page: params[:payments_page], per_page: 10)
  end
end
