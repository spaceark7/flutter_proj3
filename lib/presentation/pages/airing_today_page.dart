

import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/airing_today_tv.dart';
import 'package:ditonton/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AiringTodayPage extends StatefulWidget {
  AiringTodayPage({Key? key}) : super(key: key);
  static const String routeName = '/airing-today';
  @override
  _AiringTodayPageState createState() => _AiringTodayPageState();
}

class _AiringTodayPageState extends State<AiringTodayPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => Provider.of<AiringTodayTvNotifier>(context, listen: false)
    ..fetchAiringTodayTv());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Airing Today TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<AiringTodayTvNotifier>(
          builder: (context, data, child) {
            if (data.state == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.state == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = data.tvList[index];
                  return TvCard(tv);
                },
                itemCount: data.tvList.length,
              );
            } else {
              return Center(
                key: Key('error_message'),
                child: Text(data.message),
              );
            }
          },
        ),
      ),
    );
  }
}