class CreateGardenplantsTable < ActiveRecord::Migration[6.0]
  def change
    create_table :gardenplants do |t|
      t.integer :garden_id
      t.integer :plant_id
      t.string :status 
    end
  end
end

