class CreateElevators < ActiveRecord::Migration[7.0]
  def change
    create_table :elevators do |t|
      t.references :building, null: false, foreign_key: true
      t.string :model, null: false
      t.integer :capacity, null: false
      t.integer :status, null: false, default: 0

      t.timestamps
    end
  end
end
