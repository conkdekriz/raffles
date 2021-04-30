class AddCodeAndPayStatus < ActiveRecord::Migration[6.0]
  def change
    add_column :raffles, :code, :string
    add_column :raffles, :paid, :string
  end
end
