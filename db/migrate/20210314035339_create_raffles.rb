class CreateRaffles < ActiveRecord::Migration[6.0]
  def change
    create_table :raffles do |t|
      t.string :name
      t.string :phone
      t.string :mail
      t.integer :number

      t.timestamps
    end
  end
end
