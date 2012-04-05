class CreateChopServations < ActiveRecord::Migration
  def change
    create_table :chop_servations do |t|
      t.boolean :sighted, :default => false
      t.float :latitude
      t.float :longitude
      t.string :reason

      t.timestamps
    end
  end
end
