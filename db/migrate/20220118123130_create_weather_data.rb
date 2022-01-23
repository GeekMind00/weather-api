class CreateWeatherData < ActiveRecord::Migration[6.1]
  def change
    create_table :weather_data do |t|
      t.date :date
      t.decimal :lat, precision: 15, scale: 4
      t.decimal :lon, precision: 15, scale: 4
      t.string :city
      t.string :state

      t.timestamps
    end
  end
end
