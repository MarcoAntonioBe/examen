            import 'dart:async';
            import 'package:evaluation_app/screens/model.dart';
            import 'package:evaluation_app/screens/service.dart';
            import 'package:wear/wear.dart';
            import 'package:flutter/material.dart';
            import 'package:intl/intl.dart';


            class WeatherWidget extends StatefulWidget {
              final WeatherService weatherService;
              final WearMode mode;
////////////////////////////////
              const WeatherWidget(this.mode, {required this.weatherService});
////////////////////////////////
              @override
              _WeatherWidgetState createState() => _WeatherWidgetState();
            }


              ////////////////////////////////aqui 
              ///
            class _WeatherWidgetState extends State<WeatherWidget> {
              late WeatherData _weatherData;
              late String _hourString;
              late String _minuteString;
              late String _amPmString;

              @override
              void initState() {
                super.initState();
                _weatherData = WeatherData(
                  cityName: '',
                  temperature: 0,
                  description: '',
                  iconUrl: '',
                );
                _getTime();
                _getWeather();
              }

              void _getTime() {
                final now = DateTime.now();
                final hourFormatter = DateFormat('hh');
                final minuteFormatter = DateFormat('mm');
                final amPmFormatter = DateFormat('a');
                _hourString = hourFormatter.format(now);
                _minuteString = minuteFormatter.format(now);
                _amPmString = amPmFormatter.format(now);
                Timer.periodic(Duration(minutes: 1), (timer) {
                  final now = DateTime.now();
                  final hourFormatter = DateFormat('hh');
                  final minuteFormatter = DateFormat('mm');
                  final amPmFormatter = DateFormat('a');
                  setState(() {
                    _hourString = hourFormatter.format(now);
                    _minuteString = minuteFormatter.format(now);
                    _amPmString = amPmFormatter.format(now);
                  });
                });
              }

              Future<void> _getWeather() async {
                try {
                  final weatherData =
                      await widget.weatherService.getWeather('San Juan del Rio');
                  setState(() {
                    _weatherData = weatherData;
                  });
                } catch (e) {
                  print(e);
                }
              }

              @override
              Widget build(BuildContext context) {
                return Scaffold(
                  backgroundColor: widget.mode == WearMode.active
                      ? Color.fromARGB(207, 79, 79, 250)
                      : Colors.black,
                  body: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          DateFormat('EEEE, d MMMM yyyy').format(DateTime.now()),
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: _hourString,
                                    style: TextStyle(
                                      color: widget.mode == WearMode.active
                                          ? Colors.white
                                          : Color.fromARGB(207, 109, 124, 237),
                                      fontSize: 40,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const TextSpan(
                                    text: ':',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 40,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 2,
                            ),
                            Column(
                              children: [
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: _minuteString,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  _amPmString,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(height: 5),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${_weatherData.cityName}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              '${_weatherData.temperature}°C',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              }
            }
