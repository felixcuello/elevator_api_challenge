class AddDataToElevator < ActiveRecord::Migration[7.0]
  def change
    add_column :elevators, :data, :jsonb, null: false, default: {}
  end
end
