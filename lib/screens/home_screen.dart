import 'package:evaluation_app/screens/service.dart';
import 'package:evaluation_app/screens/weather_screen.dart';
import 'package:flutter/material.dart';
import 'package:wear/wear.dart';



class WatchScreen extends StatelessWidget {
  WatchScreen({super.key});
  final WeatherService weatherService = WeatherService();
////////////////////////////////////////////////////////////////
  @override


  ////////////////////////////////aqui
  ///
  Widget build(BuildContext context) {
    return WatchShape(
      builder: (context, shape, child) {
        return AmbientMode(
          builder: (context, mode, child) {
            return WeatherWidget(weatherService: weatherService, mode);
          },
        );
      },
    );
  }
}