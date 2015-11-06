class AddIsInviewToAirplanes < ActiveRecord::Migration
  def change
    add_column :airplanes, :is_inview, :boolean
  end
end
