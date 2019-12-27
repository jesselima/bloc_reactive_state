import 'package:bloc_reactive_state/bloc/bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';


class MockWeatherBloc extends MockBloc<WeatherEvent, WeatherState>
    implements WeatherBloc { }


main() {
  MockWeatherBloc mockWeatherBloc;

  setUp(() {
    mockWeatherBloc = MockWeatherBloc();
  });

  test('Example Mocked Bloc Test', () {
    
    whenListen(mockWeatherBloc, Stream.fromIterable([
      WeatherInitialState(),
      WeatherLoadingState()
    ]));
    
    expectLater(mockWeatherBloc, emitsInOrder([WeatherInitialState(), WeatherLoadingState()]));
    
  });
}