import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

const apiKey = '1f2d0b4ebd94e559891127ca904f2a22';
const weatherURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {

  Future getCityWeather(cityName) async{
    NetworkHelper networkHelper = NetworkHelper('$weatherURL?q=$cityName&appid=$apiKey');
    var cityWeatherData = await networkHelper.getData();
    return cityWeatherData;
  }

  Future<dynamic> getLocationWeather() async{
    Location myLocation = Location();
    await myLocation.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
        '$weatherURL?lat=${myLocation.latitude}&lon=${myLocation.longitude}&appid=$apiKey');
    var weatherData = await networkHelper.getData();

    return weatherData;
  }
  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
