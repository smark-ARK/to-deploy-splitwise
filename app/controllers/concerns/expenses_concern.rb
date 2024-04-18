module ExpensesConcern
    extend ActiveSupport::Concern

    included do
        before_action :set_current_user
        helper_method :balance_owed_by_me, :balance_owed_to_me, :total_balance, :splits_owed_by_me, :expenses_owed_to_me, :amount_owed_to_each_user, :amount_owed_by_each_user


    end

    def balance_owed_by_me
        current_user.splits.where(is_settled: false).sum(:amount)
      end
    
      def balance_owed_to_me
        current_user.expenses.joins(:splits).where(splits: {is_settled: false}).sum('splits.amount')
      end
    
      def total_balance
        balance_owed_to_me - balance_owed_by_me
      end

      def splits_owed_by_me
        Expense.joins(:splits).where(splits:{is_settled:false, participant_id: curre})
      end
    
      def expenses_owed_to_me
        current_user.expenses.joins(:splits).where(splits: {is_settled: false}).where.not(splits:{participant_id: current_user.id})
      end

    private

    def amount_owed_to_each_user
        @current_user.splits.select('users.name as payer_name', 'participant_id', 'sum(splits.amount) as total_owed')
                    .joins(:expense => :payer)
                      .where(is_settled: false)
                      .group(:participant_id, :payer_name)
                      .order('total_owed desc')
                      .to_a
      end
      def amount_owed_by_each_user
        @current_user.expenses.select('users.name as participant_name', 'splits.participant_id', 'sum(splits.amount) as total_owed')
                      .joins(:splits => :participant)
                      .where(splits: { is_settled: false })
                      .group('splits.participant_id', :participant_name)
                      .order('total_owed desc')
                      .to_a
      end
      
      

    def set_current_user
        @current_user ||= current_user
    end

    
end