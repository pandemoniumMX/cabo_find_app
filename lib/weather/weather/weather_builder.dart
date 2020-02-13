import 'package:cabofind/weather/common/constants.dart';
import 'package:cabofind/weather/weather/current_weather_service.dart';
import 'package:cabofind/weather/weather/forecast_weather_service.dart';
import 'package:cabofind/weather/weather/weather_use_case.dart';
import 'package:cabofind/weather/weather/widget/current_weather_widget.dart';
import 'package:http/http.dart' show Client;
import 'package:location/location.dart';

class WeatherBuilder {
  
  CurrentWeatherPage build() {
    Location location = Location();
    Client client = Client();

    OpenWeatherCurrentService weatherService = OpenWeatherCurrentService(client, Constants.endpoint, Constants.appId);
    OpenWeatherForecastService forecastService = OpenWeatherForecastService(client, Constants.endpoint, Constants.appId);
    WeatherUseCase useCase = WeatherUseCase(location, weatherService, forecastService);
    
    return CurrentWeatherPage(weatherUseCase: useCase);
  }

}
