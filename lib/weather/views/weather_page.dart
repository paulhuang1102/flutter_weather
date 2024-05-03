import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_report/weather/weather.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherBloc(context.read<WeatherRepository>()),
      child: const Scaffold(
        body: Column(
          children: [
            SearchBar(),
            SearchView(),
          ],
        ),
      ),
    );
  }
}

class SearchBar extends StatefulWidget {
  const SearchBar({super.key});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final TextEditingController _textController = TextEditingController();
  late WeatherBloc _weatherBloc;

  @override
  void initState() {
    _weatherBloc = context.read<WeatherBloc>();
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  String get _text => _textController.text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              controller: _textController,
              autocorrect: false,
              onChanged: (text) {
                _weatherBloc.add(
                  SearchFetch(text: text),
                );
              },
              decoration: const InputDecoration(
                hintText: '輸入臺灣縣市',
              ),
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            _weatherBloc.add(
              SearchFetch(text: _text),
            );
          },
          child: const Text('確認'),
        )
      ],
    );
  }
}

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
      return switch (state) {
        WeatherInitial() => Text('Intitial'),
        WeatherStateLoading() => Text('Loading'),
        WeatherStateEmpty() => Text('Empty'),
        WeatherStateSuccess() => Text('Success'),
        WeatherStateError() => Text('Error'),
      };
    });
  }
}
