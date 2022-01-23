class CreateWeatherTemps < ActiveRecord::Migration[6.1]
  def change
    create_table :weather_temps do |t|
      t.decimal :temp, precision: 4, scale: 1
      t.references :weather_datum, null: false, foreign_key: true

      t.timestamps
    end
  end
end
