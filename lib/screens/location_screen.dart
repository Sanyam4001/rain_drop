import 'package:flutter/material.dart';
import 'package:rain_drop/utilities/constants.dart';
import 'package:rain_drop/services/weather.dart';
import 'package:rain_drop/services/networking.dart';
import 'package:rain_drop/screens/city_screen.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen(this.locationWeather, this.cityName,{super.key});
   final locationWeather;
   final String cityName;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
   WeatherModel weather=WeatherModel();

   int ?temprature;
   int? condition;
   String ?cityName;
   String? weatherIcon;
   String ?stateName;
   String? weatherMessage;

  @override

  void initState(){
    super.initState();
    updateUI(widget.locationWeather,widget.cityName);
   
  }
  void updateUI(dynamic weatherData,String cityname) {
    setState(() {

      if(weatherData==null){
        temprature=0;
        weatherIcon='Error';
        weatherMessage='unable to fetch data';
        cityName='';
        return;
      }
      double temp = weatherData['current']['temp'];
      temprature = temp.toInt();
      var condition=weatherData['current']['weather'][0]['id'];
      weatherIcon=weather.getWeatherIcon(condition);
      cityName=cityname;


      weatherMessage=weather.getMessage(temprature!);
    });



  }



  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
              onPressed: () async{
                var weatherData=await weather.getLocationWeather();
                var cityData=await weather.getLocation();
                 updateUI(weatherData, cityData);
             },
                    child: const Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      var typedName=await Navigator.push(context, MaterialPageRoute(builder: (context){
                          return CityScreen();
                      }));
                      if(typedName!=null){
                        var weatherData=await weather.getCityWeather(typedName);
                        updateUI(weatherData,typedName);
                      }
                    },
                    child: const Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temprature°C',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon!,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
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
