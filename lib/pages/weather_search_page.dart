import 'package:bloc_reactive_state/bloc/bloc.dart';
import 'package:bloc_reactive_state/data/model/weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'weather_detail_page.dart';

class WeatherSearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather Search"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        alignment: Alignment.center,

        /// From BlocBuilder source code:
        /// [BlocBuilder] handles building a widget in response to new states.
        /// [BlocBuilder] is analogous to [StreamBuilder] but has simplified API
        /// to reduce the amount of boilerplate code needed as well as bloc-specific performance improvements.

        /// Please refer to [BlocListener] if you want to "do" anything in response to state changes such as
        /// navigation, showing a dialog, etc...
        ///
        /// If the bloc parameter is omitted, [BlocBuilder] will automatically perform a lookup using
        /// [BlocProvider] and the current [BuildContext].

        child: BlocListener<WeatherBloc, WeatherState>(

          // TODO -> Navigation, Dialog, SnackBar actions must be taken from the listener, NOT from the Builder.
          listener: (context, state) {
            if(state is WeatherErrorState) {
              Scaffold.of(context).showSnackBar(
                  SnackBar(
                      content: Text(state.message)
                  )
              );
            }
          }, // BlocListener

          child: BlocBuilder<WeatherBloc, WeatherState>(
            // ignore: missing_return
            builder: (context, state) {
              if(state is WeatherInitialState) {
                return buildInitialInput();
              } else if(state is WeatherLoadingState) {
                return buildLoading();
              } else if(state is WeatherLoadedState) {
                return buildColumnWithData(context, state.weather);
              } else if(state is WeatherErrorState) {
                return buildInitialInput();
              }
            },
          ),

        ),

      ),
    );
  }

  Widget buildInitialInput() {
    return Center(
      child: CityInputField(),
    );
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Column buildColumnWithData(BuildContext context, Weather weather) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text(
          weather.cityName,
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          // Display the temperature with 1 decimal place
          "${weather.temperatureCelsius.toStringAsFixed(1)} °C",
          style: TextStyle(fontSize: 80),
        ),
        RaisedButton(
          child: Text('See Details'),
          color: Colors.lightBlue[100],
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                // We are passing the already instance of the WeatherBloc to the provider
                value: BlocProvider.of<WeatherBloc>(context),
                child: WeatherDetailPage(
                    masterWeather: weather
                ),
              )
            ));
          },
        ),
        CityInputField(),
      ],
    );
  }
}

class CityInputField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: TextField(
        onSubmitted: (value) => submitCityName(context, value),
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: "Enter a city",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          suffixIcon: Icon(Icons.search),
        ),
      ),
    );
  }

  void submitCityName(BuildContext context, String cityName) {
    //TODO: Fetch the weather from the repository and display it somehow
    // This Suppress warning should not happen
    // ignore: close_sinks
    final weatherBloc = BlocProvider.of<WeatherBloc>(context);
    weatherBloc.add(GetWeatherEvent(cityName));

  }
}