class AddAddressToChopServations < ActiveRecord::Migration
  def change
    add_column :chop_servations, :address, :string
  end
end
