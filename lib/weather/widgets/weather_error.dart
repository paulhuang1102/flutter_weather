import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_report/weather/weather.dart';

class WeatherErrorView extends StatelessWidget {
  const WeatherErrorView(this.stateError, {super.key});
  final WeatherStateError stateError;

  @override
  Widget build(BuildContext context) {
    return switch (stateError.error) {
      ErrorType.endpointError => InkWell(
          onTap: () {
            context
                .read<WeatherBloc>()
                .add(SearchFetch(text: stateError.location));
          },
          child: const Column(
            children: [
              Icon(Icons.refresh),
              Text('錯誤，請重新整理'),
            ],
          ),
        ),
      ErrorType.inputInValid => const Text('找不到該地區，請確認輸入名稱'),
      ErrorType.system => const Text('系統錯誤')
    };
  }
}
