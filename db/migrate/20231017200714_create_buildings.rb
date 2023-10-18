class CreateBuildings < ActiveRecord::Migration[7.0]
  def change
    create_table :buildings do |t|
      t.integer :floors, null: false
      t.string :street, null: false
      t.string :city, null: false
      t.string :country, null: false

      t.timestamps
    end
  end
end
