class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string :email
      t.integer :raffle_id
      t.integer :prize_id

      t.timestamps null: false
    end
  end
end
