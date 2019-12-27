import 'package:bloc_reactive_state/bloc/bloc.dart';
import 'package:bloc_reactive_state/data/model/weather.dart';
import 'package:bloc_reactive_state/data/weather_repository_impl.dart';
import 'package:bloc_reactive_state/data/weather_repository_interface.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

/*
     SETUP MOCKS
*/
class MockWeatherRepository extends Mock implements WeatherRepository {}


void main() {

  /*
     SETUP MOCKS
  */
  MockWeatherRepository mockWeatherRepository;

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
  });


  group('GetWeather', () {

    final weather = Weather(cityName: 'London', temperatureCelsius: 7);

    test('OLD WAY test: emits [WeatherInitialState, WeatherLoadingState, WeatherLoadingState] when successfull', (){

      // Arrange
      when(mockWeatherRepository.fetchWeather(any)).thenAnswer(
          (_) async => weather
      );

      // Act
      // ignore: close_sinks
      final bloc = WeatherBloc(mockWeatherRepository);
      bloc.add(GetWeatherEvent('London'));

      // Assert/Expect
      expectLater(
          bloc,
          emitsInOrder([
            WeatherInitialState(),
            WeatherLoadingState(),
            WeatherLoadedState(weather)
          ])
      );

    });


    test('BEST WAY test: emits [WeatherInitialState, WeatherLoadingState, WeatherLoadingState] when successfull', (){

      // Arrange
      when(mockWeatherRepository.fetchWeather(any)).thenAnswer(
          (_) async => weather
      );

      // Act
      // ignore: close_sinks
      final bloc = WeatherBloc(mockWeatherRepository);
      bloc.add(GetWeatherEvent('London'));

      // Assert/Expect
      emitsExactly(bloc, [
        WeatherInitialState(),
        WeatherLoadingState(),
        WeatherLoadedState(weather) // isA<WeatherLoadedState>() without the Weather instance.
      ]);

    });


    /**
     * Bloc Test from bloc_test library
     */
    blocTest('emits [WeatherLoadingState, WeatherLoadedState] when successfull',

      /* BUILD */
      build: () {
        when(mockWeatherRepository.fetchWeather(any))
            .thenAnswer((_) async => weather);
        return WeatherBloc(mockWeatherRepository);
      },

      /* ACT */
      act: (bloc) => bloc.add(GetWeatherEvent('London')),

      /* EXPECT */
      expect: [
        WeatherInitialState(),
        WeatherLoadingState(),
        WeatherLoadedState(weather)
      ],
    );


    blocTest('emits [WeatherLoadingState, WeatherErrorState] when successfull',

      /* BUILD */
      build: () {
        when(mockWeatherRepository.fetchWeather(any))
            .thenThrow(NetworkError());
        return WeatherBloc(mockWeatherRepository);
      },

      /* ACT */
      act: (bloc) => bloc.add(GetWeatherEvent('London')),

      /* EXPECT */
      expect: [
        WeatherInitialState(),
        WeatherLoadingState(),
        WeatherErrorState('Could not fetch weather. Is device online?')
      ],
    );


  });

  /*
     WHAT HAPPENS WHEN A BLOC DEPENDS ON ANOTHER BLOC
  */



}