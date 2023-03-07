import 'package:clima/screens/screens.dart';
import 'package:clima/services/services.dart';
import 'package:clima/util/constants.dart';
import 'package:flutter/material.dart';

class LocationScreen extends StatefulWidget {
  final dynamic weatherData;
  const LocationScreen({Key? key, this.weatherData}) : super(key: key);

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weatherModel = WeatherModel();
  late double? temperature;
  late int? condition;
  late String? cityName;
  late String? weatherMessage;
  late String? weatherIcon;

  @override
  void initState() {
    updateUI(widget.weatherData);
    super.initState();
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = '';
        weatherMessage = 'Unable to get weather data';
        cityName = '';
        return;
      }

      temperature = weatherData['main']['temp'];
      condition = weatherData['weather'][0]['id'];
      cityName = weatherData['name'];
      weatherMessage = weatherModel.getMessage(temperature!.round());
      weatherIcon = weatherModel.getWeatherIcon(condition!);
    });
  }

  @override
  Widget build(BuildContext context) {
    void something() async {
      final args = ModalRoute.of(context)!.settings.arguments as LocationScreen;
    }

    something();
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage(
              'assets/images/location_background.jpg',
            ),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.8),
              BlendMode.dstATop,
            ),
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () async {
                      var weatherData =
                          await WeatherModel().getLocationWeather();
                      updateUI(weatherData);
                    },
                    child: const Icon(
                      Icons.near_me,
                      size: 50.0,
                      color: Colors.white,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      String result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CityScreen(),
                        ),
                      );
                      var weatherData =
                          await WeatherModel().getSearchedCityWeather(result);
                      updateUI(weatherData);
                    },
                    child: const Icon(
                      Icons.location_city,
                      size: 50.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          '${temperature?.round()}°C',
                          style: kTempTextStyle,
                        ),
                        Text(
                          weatherIcon!,
                          style: kConditionTextStyle,
                        ),
                      ],
                    ),
                    Text(
                      cityName!,
                      style: kMessageTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Text(
                  weatherMessage!,
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
