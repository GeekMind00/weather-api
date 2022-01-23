class WeatherTemp < ApplicationRecord
  belongs_to :weather_datum
  validates_presence_of :temp, :weather_datum_id
end
