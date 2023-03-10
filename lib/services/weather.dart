import 'package:clima/services/services.dart';

//OpenWeatherMap api key
const String _apiKey = "9429727db2c010554d4c2b3538cef713";
const openWeatherMapURL = "https://api.openweathermap.org/data/2.5/weather";

class WeatherModel {
  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return 'ð©ï¸';
    } else if (condition < 400) {
      return 'ð¦ï¸';
    } else if (condition < 600) {
      return 'ð§ï¸';
    } else if (condition < 700) {
      return 'âï¸';
    } else if (condition < 800) {
      return 'ð«ï¸';
    } else if (condition == 800) {
      return 'âï¸';
    } else if (condition <= 804) {
      return 'âï¸';
    } else {
      return 'ð¤·ââï¸';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s ð¦time';
    } else if (temp > 20) {
      return 'Time for shorts and a ð';
    } else if (temp < 10) {
      return 'You\'ll need a ð§£ and someð§¤';
    } else {
      return 'Bring a ð§¥ just in case';
    }
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();

    late double lng;
    late double lat;

    await location.getCurrentLocation();

    lng = location.getlongitudeValue;
    lat = location.getlatitudeValue;

    NetworkHelper networkHelper = NetworkHelper(
      url: '$openWeatherMapURL?lat=$lat&lon=$lng&appid=$_apiKey&units=metric',
    );

    var weatherData = await networkHelper.getData();

    return weatherData;
  }

  Future<dynamic> getSearchedCityWeather(String cityName) async {
    String url = '$openWeatherMapURL?q=$cityName&appid=$_apiKey&units=metric';

    NetworkHelper networkHelper = NetworkHelper(
      url: url,
    );

    var weatherData = await networkHelper.getData();

    return weatherData;
  }
}
