import 'package:flutter/material.dart';
import 'dart:math';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'package:clima/screens/city_screen.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationweather});

  final locationweather;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

  WeatherModel weather=WeatherModel();

  String message;
  int temperatue;
  String weatherIcon;
  String city;



  @override
  void initState() {
    super.initState();
    // print(widget.locationweather);
    updateUI(widget.locationweather);
  }
  void updateUI(dynamic weatherdata)
  {
    setState(() {

      if(weatherdata==null)
      {
          temperatue=0;
          weatherIcon='ERROR';
          message='UNABLE TO GET WEATHER DATA';
          city='---';
          return;
      }


    double temp=(weatherdata['main']['temp']-273.0);
    temperatue=temp.toInt();
    var condition=weatherdata['weather'][0]['id'];
    weatherIcon=weather.getWeatherIcon(condition);
    message=weather.getMessage(temperatue);

    city=weatherdata['name'];
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
                  FlatButton(
                    onPressed: () async {
                      var weatherData=await weather.getLocationWeather();
                      updateUI(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async{
                      var typedName=await Navigator.push(context, MaterialPageRoute(builder: (context){
                        return CityScreen();
                      },
                      ),
                      );
                      if(typedName!=null)
                        {
                          var wether=await weather.getCityWeather(typedName);
                          updateUI(wether);
                        }
                    },
                    child: Icon(
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
                      '$temperatue°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  '$message in $city !',
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
