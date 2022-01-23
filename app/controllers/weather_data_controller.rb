class WeatherDataController < ApplicationController
  include ExceptionHandler

  def index
    query_params = query_string_params
    cities = decorate_city(query_params[:city]) if query_params.key?(:city)

    @weather_data = WeatherDatum.all
    @weather_data = @weather_data.where(date: query_params[:date]) if query_params.key?(:date)
    @weather_data = @weather_data.where(city: cities) if query_params.key?(:city)

    @weather_data = case query_params[:sort]
                    when 'date'
                      @weather_data.order(date: :asc, id: :asc)
                    when '-date'
                      @weather_data.order(date: :desc, id: :asc)
                    else
                      @weather_data.order(id: :asc)
                    end

    render json: multi_decorate, status: 200
  end

  def show
    @weather_datum = WeatherDatum.find(params[:id])
    set_temps
    render json: decorate, status: 200
  end

  def create
    @weather_datum = WeatherDatum.create!(weather_datum_params)
    @weather_temps = []
    temp_data_params[:temperatures].each do |temp|
      @weather_temps << WeatherTemp.create!(weather_datum_id: @weather_datum.id, temp: temp)
    end
    render json: decorate, status: 201
  end

  private

  def weather_datum_params
    # whitelist params
    params[:city].downcase! if params.key?(:city)
    params.permit(:date, :lat, :lon, :city, :state)
  end

  def temp_data_params
    # whitelist params
    params.permit(temperatures: [])
  end

  def query_string_params
    # whitelist params
    params.permit(:date, :sort, :city)
  end

  def decorate
    {
      id: @weather_datum.id,
      date: @weather_datum.date,
      lat: @weather_datum.lat,
      lon: @weather_datum.lon,
      city: @weather_datum.city,
      state: @weather_datum.state,
      temperatures: modify_weather_temps
    }
  end

  def modify_weather_temps
    weather_temps_modified = []
    @weather_temps.each do |temp|
      weather_temps_modified << { id: temp.id, temp: temp.temp }
    end
    weather_temps_modified
  end

  def decorate_city(cities)
    cities.downcase!
    cities.split(',')
  end

  def multi_decorate
    decorated_res = []
    @weather_data.each do |weather_datum|
      @weather_datum = weather_datum
      set_temps
      decorated_res << decorate
    end
    decorated_res
  end

  def set_temps
    @weather_temps = WeatherTemp.where(weather_datum_id: @weather_datum.id)
  end
end
