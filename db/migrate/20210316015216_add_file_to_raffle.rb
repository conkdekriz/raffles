class AddFileToRaffle < ActiveRecord::Migration[6.0]
  def change
    add_column :raffles, :file, :string
  end
end
