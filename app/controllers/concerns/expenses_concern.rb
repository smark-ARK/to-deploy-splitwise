module ExpensesConcern
    extend ActiveSupport::Concern

    included do
        before_action :set_current_user
        helper_method :get_stats, :people_you_owe, :people_who_owe_you
    end

    def people_who_owe_you
        Friendship.joins(:user).where(user_id: 11).where("balance > ?",0)
      end
    
      def people_you_owe
        Friendship.joins(:user).where(user_id: 11).where("balance < ?",0)
      end

    private

    def get_stats
      Friendship.find_by_sql("
      SELECT SUM(CASE WHEN balance < 0 THEN balance ELSE 0 END) AS amount_you_owe,
             SUM(CASE WHEN balance > 0 THEN balance ELSE 0 END) AS amount_owed_to_you,
             SUM(balance) AS total_balance
      FROM friendships
      WHERE user_id = #{@current_user.id}
    ").first
    end

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