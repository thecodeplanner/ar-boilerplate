class CreateGardensTable < ActiveRecord::Migration[6.0]
  def change
    create_table :gardens do |t|
      t.string :username
      t.string :password
      t.string :garden_name
    end
  end
end
