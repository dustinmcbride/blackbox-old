class ChangesToSettings < ActiveRecord::Migration
  def change
    add_column :settings, :originlat, :float
    add_column :settings, :originlon, :float

    add_column :settings, :rightlat, :float
    add_column :settings, :rightlon, :float

    add_column :settings, :leftlat, :float
    add_column :settings, :leftlon, :float

    add_column :settings, :use, :boolean

    remove_column :settings, :location
    remove_column :settings, :leftpoint
    remove_column :settings, :rightpoint
  end
end
