import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_report/weather/weather.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherBloc(context.read<WeatherRepository>()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            '台灣地區天氣查詢',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        body: const Column(
          children: [
            SearchBar(),
            Expanded(child: SearchView()),
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

  String get _text => _textController.text.trim();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textController,
              autocorrect: false,
              onChanged: (text) {
                _weatherBloc.add(
                  SearchFetch(text: _text),
                );
              },
              decoration: const InputDecoration(
                hintText: '輸入臺灣縣市',
              ),
            ),
          ),
          OutlinedButton(
            onPressed: () {
              _weatherBloc.add(
                SearchFetch(text: _text),
              );
            },
            child: const Text('確認'),
          )
        ],
      ),
    );
  }
}

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
        return switch (state) {
          WeatherStateInitial() => const WeatherInitial(),
          WeatherStateLoading() => const WeatherLoading(),
          WeatherStateSuccess() => WeatherResultView(state.weather),
          WeatherStateError() => WeatherErrorView(state),
        };
      }),
    );
  }
}
