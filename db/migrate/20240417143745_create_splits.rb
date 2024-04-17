class CreateSplits < ActiveRecord::Migration[6.1]
  def change
    create_table :splits do |t|
      t.references :expense, null: false, foreign_key: true, index:true
      t.references :participant, null: false, foreign_key: {to_table: :users}, index: true
      t.decimal :amount, null:false
      t.boolean :is_settled,default:false
      t.datetime :settled_at

      t.timestamps
    end
  end
end
