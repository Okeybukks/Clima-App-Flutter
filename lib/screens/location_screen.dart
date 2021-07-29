import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'city_screen.dart';
import '../services/weather.dart';

class LocationScreen extends StatefulWidget {

  final locationData;
  const LocationScreen({this.locationData});

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

  WeatherModel weatherModel = WeatherModel();
  int tempConvert(double value){
    return (value - 273.15).round();
  }
  var condition;
  var temperature;
  var cityName;
  var weatherMessage;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateUI(widget.locationData);
  }

  void updateUI(locationData){
    setState(() {
      if(locationData == null){
        weatherMessage = 'Unable to get weather data';
        temperature = 0;
        condition = 'Error';
        cityName = '';
        // return;
      }
      else{
      condition = weatherModel.getWeatherIcon(locationData['weather'][0]['id']);
      temperature = tempConvert(locationData['main']['temp']);
      cityName = locationData['name'];
      weatherMessage = weatherModel.getMessage(temperature);}
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    onPressed: () async{
                      var weatherData = await weatherModel.getLocationWeather();
                      updateUI(weatherData);
                    },
                    icon: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      var cityName = await Navigator.push(context, MaterialPageRoute(builder: (context)=>CityScreen()));
                      if(cityName != null){
                        var weatherData = await weatherModel.getCityWeather(cityName);
                        updateUI(weatherData);
                      }
                    },
                    icon: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      condition,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "$weatherMessage in $cityName",
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

