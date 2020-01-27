import 'package:cabofind/weather/weather/weather_result.dart';
import 'package:cabofind/weather/weather/weather_use_case.dart';
import 'package:flutter/material.dart';
import 'weather_widget.dart';
import 'forecast_widget.dart';


class CurrentWeatherPage extends StatefulWidget {

  final WeatherUseCase weatherUseCase;
  static final Key progressKey = Key("current_weather_widget_progress");
  static final Key weatherKey = Key("current_weather_widget_weather");
  static final Key errorKey = Key("current_weather_widget_error");

  CurrentWeatherPage({Key key, this.weatherUseCase}) : super(key: key);

  @override
  _CurrentWeatherPageState createState() => _CurrentWeatherPageState();

}

class _CurrentWeatherPageState extends State<CurrentWeatherPage> {

  @override
  Widget build(BuildContext context) {    
    return Scaffold(
      appBar: AppBar(
        title: Text("CLIMA - WEATHER"),
        actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              tooltip: 'Reload',
              onPressed: () {
                setState(() {
                  //TODO: 
                });    
              },
            )
        ]
      ),
      body: Center(
        child: FutureBuilder<WeatherResult>(
            future: widget.weatherUseCase.get(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                WeatherResult weatherResult = snapshot.data;
                return _drawWeather(weatherResult);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}", key: CurrentWeatherPage.errorKey);
              }
              return CircularProgressIndicator(key: CurrentWeatherPage.progressKey);
            },
          ),
      )
    );
  }

  Container _drawWeather(WeatherResult weatherResult) {
    Container container = Container(
              key: CurrentWeatherPage.weatherKey,
              margin: EdgeInsets.all(0),
              child: Padding(padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: <Widget>[
                    WeatherPage(weather: weatherResult.weather),
                    ForecastPage(forecast: weatherResult.forecast)
                ],
               ),
              ),
            );
    return container;
  }

}