class ExpenseController < ApplicationController
    def create
      @expense = Expense.create(expense_params.except(:splits_attributes, :split_type))

    if @expense.save
      expense_params[:splits_attributes].each do |index, split|
        puts split[:participant_id]
        puts @expense.payer_id
        @is_settled = split[:participant_id] == @expense.payer_id ? true : false
        @settled_at = split[:participant_id] == @expense.payer_id ? Time.current : nil
        @expense.splits.create!(participant_id: split[:participant_id], amount: split[:participant_result], is_settled: @is_settled, settled_at: @settled_at)
      end
      redirect_to root_path, notice: 'Expense was successfully created.'
    else
      render 'static/dashboard'
      end
    end
  
    private
  
    def expense_params
      params.require(:expense).permit(:amount, :title, :description, :media, :payer_id, :split_type, splits_attributes: [:participant_id, :participant_result, :participant_amount])
    end
  end
  