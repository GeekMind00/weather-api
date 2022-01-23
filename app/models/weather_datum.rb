class WeatherDatum < ApplicationRecord
  has_many :weather_temps, dependent: :destroy
  validates_presence_of :date, :lat, :lon, :city, :state
end
