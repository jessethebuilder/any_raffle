class CreatePrizes < ActiveRecord::Migration
  def change
    create_table :prizes do |t|
      t.integer :raffle_id

      t.string :name
      t.text :description
      t.float :value
      t.float :cost

      t.timestamps null: false
    end
  end
end
