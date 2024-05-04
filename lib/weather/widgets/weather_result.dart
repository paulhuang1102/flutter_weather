import 'package:flutter/material.dart';
import 'package:weather_report/weather/weather.dart';

class WeatherResultView extends StatelessWidget {
  const WeatherResultView(this._weather, {super.key});

  final Weather _weather;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: _weather.data.map((e) => WeatherResultItem(e)).toList(),
      ),
    );
  }
}

class WeatherResultItem extends StatelessWidget {
  const WeatherResultItem(this._data, {super.key});
  final WeatherData _data;

  @override
  Widget build(BuildContext context) {
    final param = _data.parameters;
    final maxt = param[ShowParam.maxt.value]!;
    final mint = param[ShowParam.mint.value]!;
    final ci = param[ShowParam.ci.value]!;
    final wx = param[ShowParam.wx.value]!;
    final pop = param[ShowParam.pop.value]!;
    final style = Theme.of(context).textTheme.titleSmall!.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 14.0,
        );

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16.0),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Text(
                '${_data.startTime.toCustomTime} - ${_data.endTime.toCustomTime}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const Spacer(),
              Text(
                '${mint.name}${mint.unit}~${maxt.name}${maxt.unit}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
          const SizedBox(
            height: 16.0,
          ),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(16.0),
            ),
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Text(
                  '降雨機率 ${pop.name} ${pop.unit}',
                  style: style,
                ),
                Text(
                  wx.name,
                  style: style,
                ),
                Text(
                  ci.name,
                  style: style,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
