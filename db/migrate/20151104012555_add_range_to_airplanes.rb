class AddRangeToAirplanes < ActiveRecord::Migration
  def change
    add_column :airplanes, :range, :float
  end
end
