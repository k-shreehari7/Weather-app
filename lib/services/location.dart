import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
class Location
{
  double lat;
  double long;
  // Location({this.latitude,this.longitude});
  Future<void> getCurrentLocation() async
  {
    try {
      Position position = await Geolocator().getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      lat=double.parse(position.latitude.toString());
      long=double.parse(position.longitude.toString());
    }
    catch(e)
    {
      print(e);
    }

  }

}

