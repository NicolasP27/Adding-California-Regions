import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';


class WorldWeather {
  final apiKey = '9aaa85272e6a6a88c445b1c5e1ebed39';

  String? skateparkname; //location name for the UI
  String? weather; //the weather in that city
  String? address; //address of park for UI
  String? parksize; //size of park for UI
  String? lights; //lights at park or not for UI
  String? padrequirement; //pads required at park or not for UI
  String? times; //times the park is open
  String? skateparkPicture; //url to an asset of city picture
  String? city; //city for upi endpoint



  WorldWeather({
    @required this.city,
    @required this.skateparkname,
    @required this.address,
    @required this.parksize,
    @required this.lights,
    @required this.padrequirement,
    @required this.times,
    @required this.skateparkPicture,

  });

  Future<String> getWeather() async {
    //make the request
    Response response = await get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=imperial'));
    Map weatherdata = jsonDecode(response.body);
    //String description = weatherdata["weather"][0]["description"].toString();
    String temp = weatherdata['main']['temp'].toString() + ' F';
    //print(temp);

    return weather = temp.substring(0, 3) + ' °F';
  }

  //WorldWeather._();

  Future<void> openMap() async {
    String googleUrl = 'https://www.google.com/maps/place/$address';
    String appleMapsUrl = 'https://maps.apple.com/?q=$address';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    }
    if (await canLaunch(appleMapsUrl)){
      await launch(appleMapsUrl);
    }
    else {
      throw 'Could not open the map.';
    }
  }

}

