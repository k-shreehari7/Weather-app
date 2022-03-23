import 'package:clima/services/location.dart';
import 'package:flutter/material.dart';
import 'package:clima/services/networking.dart';
import 'location_screen.dart';
import 'package:clima/services/weather.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  double lattidue;
  double longitude;

  @override
  void initState() {
    super.initState();
    getLocationData();

  }
  void getLocationData() async
  {



    WeatherModel weatherModel=WeatherModel();
    var weatherdata=await weatherModel.getLocationWeather();

    Navigator.push(context, MaterialPageRoute(builder:(context){
    return LocationScreen(locationweather: weatherdata);
    }));


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: SpinKitChasingDots(
        color: Colors.white,
        size: 50.0,

      ),
    );
  }
}
