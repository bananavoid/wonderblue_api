class CreateTidelines < ActiveRecord::Migration[5.0]
  def change
    create_table :tidelines do |t|
      t.string :name
      t.string :lat
      t.string :lon
      t.string :wave_length
      t.string :swell_direction
      t.string :tide
      t.string :wind

      t.timestamps
    end
  end
end
