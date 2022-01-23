require 'rails_helper'

def json
  JSON.parse(response.body)
end
RSpec.describe WeatherDataController, type: :request do
  # initialize test data
  let!(:weather_data) do
    {
      "date": '2005-04-05',
      "lat": 36.1189,
      "lon": -86.6892,
      "city": 'New York',
      "state": 'kayn',
      "temperatures": [17.3, 16.8, 16.4, 16.0]
    }
  end
  let(:weather_id) { 1 }

  # Test suite for GET /weather/:id
  describe 'GET /weather/:id' do
    before { post '/weather', params: weather_data }
    before { get "/weather/#{weather_id}" }

    context 'when the record exists' do
      it 'returns the weather data' do
        expect(response.body).not_to be_empty
        expect(json['id']).to eq(weather_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:weather_id) { 164_854 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find WeatherDatum with 'id'=#{weather_id}/)
      end
    end
  end

  # Test suite for POST /weather
  describe 'POST /weather' do
    # valid payload
    let(:valid_attributes) do
      {
        date: '2015-04-05',
        lat: 36.1189,
        lon: -86.6892,
        city: 'New York',
        state: 'kayn',
        temperatures: [17.3, 16.8, 16.4, 16.0]
      }
    end

    context 'when the request is valid' do
      before { post '/weather', params: valid_attributes }

      it 'creates a weather data' do
        expect(json['date']).to eq('2015-04-05')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before do
        post '/weather', params: {
          "lat": 36.1189,
          "lon": -86.6892,
          "city": 'New York',
          "state": 'kayn',
          "temperatures": [17.3, 16.8, 16.4, 16.0]
        }
      end

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Date can't be blank/)
      end
    end
  end
end
