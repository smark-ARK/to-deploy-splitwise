class CreatePayments < ActiveRecord::Migration[6.1]
  def change
    create_table :payments do |t|
      t.references :from_user, null:false, foreign_key:{to_table: :users}, index:true
      t.references :to_user, null:false, foreign_key:{to_table: :users}, index:true
      t.decimal :amount, null: false
      t.text :note
      t.string :method, default: :cash, null: false

      t.timestamps
    end
  end
end
