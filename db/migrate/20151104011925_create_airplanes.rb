class CreateAirplanes < ActiveRecord::Migration
  def change
    create_table :airplanes do |t|
      t.string :hex
      t.integer :sqawk
      t.string :flight
      t.float :lat
      t.float :lon
      t.integer :validposition
      t.integer :altitude
      t.integer :vert_rate
      t.integer :track
      t.integer :validtrack
      t.integer :speed
      t.integer :messages
      t.integer :seen
      t.boolean :mlat

      t.timestamps null: false
    end
  end
end
