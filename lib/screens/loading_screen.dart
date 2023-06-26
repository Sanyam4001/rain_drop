// import 'dart:js';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:rain_drop/services/weather.dart';

import 'location_screen.dart';




class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late double latitude;
  late double longitude;
  @override
  void initState(){
    super.initState();
    getLocation();

  }


  Future<void> getLocation() async {


    var weatherData=await WeatherModel().getLocationWeather();
    var cityData=await WeatherModel().getLocation();

    Navigator.push(context as BuildContext, MaterialPageRoute(builder: (context){
       return LocationScreen(weatherData,cityData);
    }));
  }


  Widget build(BuildContext context) {

    return  const Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100,
        ),
      ),
    );
  }



}


