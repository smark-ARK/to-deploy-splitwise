class CreateExpenses < ActiveRecord::Migration[6.1]
  def change
    create_table :expenses do |t|
      t.decimal :amount, null: false
      t.string :title, null: false
      t.text :description
      t.string :media
      t.references :payer, null: false, foreign_key: {to_table: :users}, index:true

      t.timestamps
    end
  end
end
