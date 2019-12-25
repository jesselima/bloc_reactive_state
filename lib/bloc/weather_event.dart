import 'package:equatable/equatable.dart';

// TODO -> 3 - Implement Event classes

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();
}


class GetWeatherEvent extends WeatherEvent {
  final String cityName;
  GetWeatherEvent(this.cityName);

  @override
  List<Object> get props => [cityName];
}



class GetDetailedWeatherEvent extends WeatherEvent {
  final String cityName;
  GetDetailedWeatherEvent(this.cityName);

  @override
  List<Object> get props => [cityName];
}
