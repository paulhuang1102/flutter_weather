import 'package:flutter/material.dart';

class WeatherLoading extends StatelessWidget {
  const WeatherLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text('讀取天氣資料中'),
        CircularProgressIndicator(),
      ],
    );
  }
}