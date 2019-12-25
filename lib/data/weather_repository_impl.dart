import 'dart:math';

import 'model/weather.dart';
import 'weather_repository_interface.dart';


class WeatherRepositoryImpl implements WeatherRepository {

  double cachedTempCelsius;
  double temperatureFahrenheit;

  @override
  Future<Weather> fetchWeather(String cityName) {
    // Simulate network delay
    return Future.delayed(
      Duration(seconds: 1),
          () {
        final random = Random();

        // Simulate some network error
        if (random.nextBool()) {
          throw NetworkError();
        }

        // Since we're inside a fake repository, we need to cache the temperature
        // in order to have the same one returned in for the detailed weather
        cachedTempCelsius = 20 + random.nextInt(15) + random.nextDouble();
        temperatureFahrenheit = (cachedTempCelsius * 1.8) + 32;

        // Return "fetched" weather
        return Weather(
          cityName: cityName,
          // Temperature between 20 and 35.99
          temperatureCelsius: cachedTempCelsius,
          temperatureFahrenheit: temperatureFahrenheit
        );
      },
    );
  }

  @override
  Future<Weather> fetchDetailedWeather(String cityName) {
    // Simulate network delay
    return Future.delayed(
      Duration(seconds: 1),
          () {
        return Weather(
          cityName: cityName,
          temperatureCelsius: cachedTempCelsius,
          temperatureFahrenheit: cachedTempCelsius,
        );
      },
    );
  }
}

class NetworkError extends Error {}