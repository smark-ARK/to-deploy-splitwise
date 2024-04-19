class UsersController < ApplicationController
  include FriendsConcern
    before_action :authenticate_user!
  
    def show
      @friends = fetch_friends
      @user = User.find(params[:id])
      @expenses = Split.joins(:expense, :participant).where(participant_id: [current_user.id, @user.id], expense:{payer_id:[current_user.id, @user.id]}, is_settled: false).order(created_at: :desc).paginate(page: params[:splits_page], per_page: 10)
      @expense = Expense.new
      @payment = Payment.new
      @payments = @user.payments.paginate(page: params[:payments_page], per_page: 10)
    end
    
  
    def edit
      @user = User.find(params[:id])
      if @user != current_user
        redirect_to root_path, alert: "You can only edit your own profile."
      end
    end
  
    def update
      @user = User.find(params[:id])
      if @user.update(user_params)
        redirect_to @user, notice: "Profile updated successfully."
      else
        render :edit
      end
    end
  
    def add_friend
      @friend_ids = friendship_params[:user_ids] # get friend_ids from params
    
      @friend_ids.each do |friend_id|
        next if friend_id.blank?
        @friend = User.find(friend_id)
        unless current_user.friends.include?(@friend)
          current_user.friends << @friend
        end
      end
    
      if current_user.save
        flash[:notice] = "Friends added successfully."
      else
        flash[:alert] = "Unable to add friends."
      end
    
      redirect_to root_path # replace with your desired path
    end

    def expenses
      @all_expenses = Split.joins(:expense, :participant)
                     .where(expense:{ payer_id: current_user.id})
                     .order(created_at: :desc)
    end
    
  
    def remove_friend
      delete_friend
    end
  
    private
  
    def user_params
      params.require(:user).permit(:name, :email) # Add other attributes here
    end

    private

    def friendship_params
      params.require(:friendship).permit(user_ids: [])
    end

  end
  