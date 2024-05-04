import 'package:flutter/material.dart';

class WeatherInitial extends StatelessWidget {
  const WeatherInitial({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('在上方輸入框填入地區，以搜尋天氣資訊'),
    );
  }
}