class CreatePrices < ActiveRecord::Migration[6.0]
  def change
    create_table :prices do |t|
      t.string :name
      t.string :rrss
      t.text :description
      t.integer :number
      t.string :photo

      t.timestamps
    end
  end
end
