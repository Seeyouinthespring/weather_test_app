import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weather_test_app/presentation/bloc/weather_bloc/weather_event.dart';
import 'package:weather_test_app/presentation/bloc/weather_bloc/weather_state.dart';
import '../../di.dart' as di;
import 'package:weather_test_app/presentation/bloc/weather_bloc/weather_bloc.dart';

import '../components/forecast_sector_widget.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0700FF),
              Color(0xFF000000),
            ],
          ),
        ),
        child: BlocProvider(
          create: (_) => di.locator<WeatherBloc>()..add(const OnInit()),

          child: BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, state) {
              if (state is WeatherLoading) {
                print('WEATHER LOADING');
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is WeatherError) {
                print('WEATHER ERROR');
                return Center(
                  child: Text(state.message),
                );
              }
              if (state is WeatherData) {
                print('WEATHER DATA');
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                        left: 24,
                        right: 24,
                        top: 24 + MediaQueryData.fromWindow(window).padding.top,
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/svg/pin.svg',
                            height: 24,
                            width: 24,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Text(
                              state.data.location,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 250,
                          height: 250,
                          decoration: BoxDecoration(
                            gradient: const RadialGradient(
                              colors: [
                                Color(0xFFBD87FF),
                                Color(0x00BD87FF),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(125),
                          ),
                        ),
                        Image.asset(
                          'assets/png/thunder.png',
                          width: 180,
                          height: 180,
                        ),
                      ],
                    ),
                    Text(
                      '${state.data.currentT}º',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 64,
                        fontWeight: FontWeight.w500,
                        height: 0.9,
                      ),
                    ),
                    Text(
                      'Гроза - ${state.data.currentWeatherDescription}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      'Макс.: ${state.data.minT}º Мин: ${state.data.maxT}º',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(24),
                      height: 230,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom:
                                    BorderSide(width: 1, color: Colors.white),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Сегодня',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  '${state.data.currentDate.day} ${state.data.currentDate.month}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              child: IntrinsicHeight(
                                child: Row(
                                  children: state.data.comingHours
                                      .map(
                                        (e) => ForecastSectorWidget(
                                          isSelected: e.dateTime.compareTo(
                                                  state.data.selected) ==
                                              0,
                                          forecast: e,
                                        ),
                                      )
                                      .toList(),
                                  // children: [
                                  //   Expanded(
                                  //     flex: 1,
                                  //     child: Column(
                                  //       mainAxisAlignment:
                                  //       MainAxisAlignment.spaceEvenly,
                                  //       children: [
                                  //         Text(
                                  //           '14:00',
                                  //           style: TextStyle(
                                  //               color: Colors.white,
                                  //               fontSize: 15,
                                  //               fontWeight: FontWeight.w400),
                                  //         ),
                                  //         SvgPicture.asset(
                                  //           'assets/svg/Sun.svg',
                                  //           width: 32,
                                  //           height: 32,
                                  //         ),
                                  //         Text('28º',
                                  //             style: TextStyle(
                                  //                 color: Colors.white,
                                  //                 fontSize: 17,
                                  //                 fontWeight: FontWeight.w500)),
                                  //       ],
                                  //     ),
                                  //   ),
                                  //   Expanded(
                                  //     flex: 1,
                                  //     child: Container(
                                  //       // decoration: BoxDecoration(
                                  //       //     border: Border.all(color: Colors.white),
                                  //       //     borderRadius: BorderRadius.all(Radius.circular(6))
                                  //       // ),
                                  //       child: Column(
                                  //         mainAxisAlignment:
                                  //         MainAxisAlignment.spaceEvenly,
                                  //         children: [
                                  //           Text(
                                  //             '14:00',
                                  //             style: TextStyle(
                                  //                 color: Colors.white,
                                  //                 fontSize: 15,
                                  //                 fontWeight: FontWeight.w400),
                                  //           ),
                                  //           SvgPicture.asset(
                                  //             'assets/svg/Sun.svg',
                                  //             width: 32,
                                  //             height: 32,
                                  //           ),
                                  //           Text('28º',
                                  //               style: TextStyle(
                                  //                   color: Colors.white,
                                  //                   fontSize: 17,
                                  //                   fontWeight: FontWeight.w500)),
                                  //         ],
                                  //       ),
                                  //     ),
                                  //   ),
                                  //   Expanded(
                                  //     flex: 1,
                                  //     child: Container(
                                  //       // decoration: BoxDecoration(
                                  //       //     border: Border.all(color: Colors.white),
                                  //       //     borderRadius: BorderRadius.all(Radius.circular(6))
                                  //       // ),
                                  //       child: Column(
                                  //         mainAxisAlignment:
                                  //         MainAxisAlignment.spaceEvenly,
                                  //         children: [
                                  //           Text(
                                  //             '14:00',
                                  //             style: TextStyle(
                                  //               color: Colors.white,
                                  //               fontSize: 15,
                                  //               fontWeight: FontWeight.w400,
                                  //             ),
                                  //           ),
                                  //           SvgPicture.asset(
                                  //             'assets/svg/Sun.svg',
                                  //             width: 32,
                                  //             height: 32,
                                  //           ),
                                  //           Text(
                                  //             '28º',
                                  //             style: TextStyle(
                                  //               color: Colors.white,
                                  //               fontSize: 17,
                                  //               fontWeight: FontWeight.w500,
                                  //             ),
                                  //           ),
                                  //         ],
                                  //       ),
                                  //     ),
                                  //   ),
                                  //   Expanded(
                                  //     flex: 1,
                                  //     child: Container(
                                  //       decoration: BoxDecoration(
                                  //         color: Colors.white.withOpacity(0.4),
                                  //         border: Border.all(color: Colors.white),
                                  //         borderRadius:
                                  //         BorderRadius.all(Radius.circular(6)),
                                  //       ),
                                  //       child: Column(
                                  //         mainAxisAlignment:
                                  //         MainAxisAlignment.spaceEvenly,
                                  //         children: [
                                  //           Text(
                                  //             '14:00',
                                  //             style: TextStyle(
                                  //               color: Colors.white,
                                  //               fontSize: 15,
                                  //               fontWeight: FontWeight.w400,
                                  //             ),
                                  //           ),
                                  //           SvgPicture.asset(
                                  //             'assets/svg/Sun.svg',
                                  //             width: 32,
                                  //             height: 32,
                                  //           ),
                                  //           Text(
                                  //             '28º',
                                  //             style: TextStyle(
                                  //               color: Colors.white,
                                  //               fontSize: 17,
                                  //               fontWeight: FontWeight.w500,
                                  //             ),
                                  //           ),
                                  //         ],
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.symmetric(horizontal: 24),
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: const BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      WidgetSpan(
                                        child: SvgPicture.asset(
                                            'assets/svg/Wind.svg',
                                        ),
                                      ),
                                      WidgetSpan(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Text(
                                            '${state.data.windSpeed} м/с',
                                            style: TextStyle(
                                              color: Colors.white.withOpacity(0.2),
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  "${state.data.windDirection}Ветер восточный",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      WidgetSpan(
                                        child: SvgPicture.asset(
                                            'assets/svg/Drop.svg',
                                        ),
                                      ),
                                      WidgetSpan(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Text(
                                            '${state.data.humidity} %',
                                            style: TextStyle(
                                              color:
                                                  Colors.white.withOpacity(0.2),
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  "${state.data.humidityDescription} влажность",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
              print('WEATHER ELSE');
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}
