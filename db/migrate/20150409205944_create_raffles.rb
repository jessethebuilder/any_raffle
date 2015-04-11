class CreateRaffles < ActiveRecord::Migration
  def change
    create_table :raffles do |t|
      t.integer :user_id
      t.string :title
      t.text :description
      t.string :image
      t.datetime :end_time
      t.string :slug
      t.float :ticket_price

      t.timestamps null: false
    end
  end
end
