import 'package:flutter/material.dart';
import 'package:weather_report/weather/weather.dart';

class WeatherResultView extends StatelessWidget {
  const WeatherResultView(this._weather, {super.key});

  final Weather _weather;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: _weather.data.map((e) => Column(
          children: [
            // Text(e.startTime.toString()),
            Text('${e.parameters[ShowParam.mint.value]!.name}${e.parameters[ShowParam.mint.value]?.unit}~${e.parameters[ShowParam.maxt.value]!.name}${e.parameters[ShowParam.maxt.value]?.unit}'),
            Text('降雨機率 ${e.parameters[ShowParam.pop.value]!.name} ${e.parameters[ShowParam.pop.value]?.unit}'),
            Text(e.parameters[ShowParam.wx.value]!.name),
            Text(e.parameters[ShowParam.ci.value]!.name),
          ],
        )).toList(),
      ),
    );
  }
}