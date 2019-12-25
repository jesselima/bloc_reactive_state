import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bloc_reactive_state/data/weather_repository_impl.dart';
import 'package:bloc_reactive_state/data/weather_repository_interface.dart';
import 'bloc.dart';


class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {

  /*
   Use the abstract (~interface) class to decouple code.
   */
  final WeatherRepository weatherRepository;

  WeatherBloc(this.weatherRepository);


  /*
   Every Bloc Overrides 2 members. initialState and mapEventToState.
   */

  // async* stands for "async generator"

  @override
  WeatherState get initialState => WeatherInitialState();

  // The most important thing for reactive, the Stream. Bloc uses the Stream under the hood.
  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    // TODO: Add Logic
    /* We use the "yield" to output state to the stream */

    yield WeatherLoadingState(); // Will Show the progress indicator

    if (event is GetWeatherEvent) {
      try {
        final weather = await weatherRepository.fetchWeather(event.cityName);
        yield WeatherLoadedState(weather);
      } on NetworkError {
        yield WeatherErrorState("Could not fetch waether. Is device online?");
      }
    } else if (event is GetDetailedWeatherEvent) {
      try {
        final weather = await weatherRepository.fetchDetailedWeather(event.cityName);
        yield WeatherLoadedState(weather);
      } on NetworkError {
        yield WeatherErrorState("Could not fetch waether details. Is device online?");
      }
    }
    


  }
}
