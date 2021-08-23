import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:skate_guide_cali_mk5/services/weather.dart';


class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  void setupWorldWeather() async {
    WorldWeather instance = WorldWeather(
      skateparkname: 'Home',
      address: 'null',
      parksize: 'null',
      lights: 'null',
      padrequirement: 'null',
      skateparkPicture: 'greece.png',
      city: 'mar+vista,us',
      times: 'null',

    );

    await instance.getWeather();
    instance.weather = await instance.getWeather();
    Navigator.pushReplacementNamed(context, '/mainpage', arguments: {
      'location': instance.skateparkname,
      'skateparkPicture': instance.skateparkPicture,
      'weather': instance.weather,
      'address': instance.address,
      'parksize': instance.parksize,
      'lights': instance.lights,
      'padrequirement': instance.padrequirement,
      'times': instance.times,


    });
  }





  @override
  void initState() {
    super.initState();
    setupWorldWeather();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: const Center(
        child: SpinKitFoldingCube(
          color: Colors.white,
          size: 80.0,
        ),
      ),
    );
  }
}