import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weather_test_app/presentation/bloc/weather_bloc/weather_event.dart';
import 'package:weather_test_app/presentation/bloc/weather_bloc/weather_state.dart';
import 'package:weather_test_app/presentation/components/custom_text_header.dart';
import 'package:weather_test_app/presentation/components/custom_text_label.dart';
import 'package:weather_test_app/utils/constants/icons_maps.dart';
import 'package:weather_test_app/utils/models/extensions.dart';
import '../../di.dart' as di;
import 'package:weather_test_app/presentation/bloc/weather_bloc/weather_bloc.dart';

import '../../utils/constants/months.dart';
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
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                );
              }
              if (state is WeatherError) {
                return Center(
                  child: Text(state.message,
                      style: const TextStyle(color: Colors.white)),
                );
              }
              if (state is WeatherData) {
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
                            child: CustomTextHeader(text: state.data.location),
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
                          'assets/png/${IconsMaps.iconNames[state.data.currentWeatherDescription]}.png',
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
                    CustomTextLabel(
                        text: state
                            .data.currentWeatherDescriptionDetailed.capitalize),
                    CustomTextLabel(
                        text:
                            'Мин.: ${state.data.minT}º Макс: ${state.data.maxT}º'),
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
                                const CustomTextHeader(text: 'Сегодня'),
                                CustomTextHeader(
                                    text:
                                        '${state.data.currentDate.day} ${Calendar.months[state.data.currentDate.month]}'),
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
                                        (e) => Expanded(
                                          child: GestureDetector(
                                            onTap: () => context
                                                .read<WeatherBloc>()
                                                .add(OnSelectSection(
                                                    e.dateTime)),
                                            child: ForecastSectorWidget(
                                              isSelected: e.dateTime.compareTo(
                                                      state.data.selected) ==
                                                  0,
                                              forecast: e,
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
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
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
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
                                child: CustomTextHeader(
                                    text: state.data.windDirection),
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
                                child: CustomTextHeader(
                                    text:
                                        "${state.data.humidityDescription} влажность"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
              return const Center(
                child: Text(
                  'Unknown state',
                  style: TextStyle(color: Colors.white),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
