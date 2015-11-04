class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.float :location
      t.float :leftpoint
      t.float :rightpoint
      t.float :cloudceiling
      t.datetime :sunset
      t.datetime :sunrise
      t.float :dayrange
      t.float :nightrange

      t.timestamps null: false
    end
  end
end
