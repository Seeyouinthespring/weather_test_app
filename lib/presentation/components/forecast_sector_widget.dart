import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:weather_test_app/domain/models/forecast_view_model.dart';
import 'package:weather_test_app/utils/constants/icons_maps.dart';

class ForecastSectorWidget extends StatelessWidget {
  final bool isSelected;
  final ComingHour forecast;

  const ForecastSectorWidget(
      {super.key, required this.isSelected, required this.forecast});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: isSelected ? BoxDecoration(
        color: Colors.white.withOpacity(0.4),
        border: Border.all(color: Colors.white),
        borderRadius:
        const BorderRadius.all(Radius.circular(6)),
      ) : const BoxDecoration(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            DateFormat("HH:mm").format(forecast.dateTime),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
          SvgPicture.asset(
            'assets/svg/${IconsMaps.iconNames[forecast.weatherDescription]}.svg',
            width: 32,
            height: 32,
          ),
          Text(
            '${forecast.t}º',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
