class AddToSettings < ActiveRecord::Migration
  def change
      add_column :settings, :update_in_bg, :boolean
      add_column :settings, :use_flightaware_api, :boolean
      add_column :settings, :fa_starttime, :time
      add_column :settings, :fa_stoptime, :time
      add_column :settings, :dump1090url, :string
      add_column :settings, :refreshrate, :integer

      add_column :settings, :farrightlat, :float
      add_column :settings, :farrightlon, :float
      add_column :settings, :farleftlat, :float
      add_column :settings, :farleftlon, :float
  end
end
