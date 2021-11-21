

import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/on_the_air_notifier.dart';
import 'package:ditonton/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OnTheAirPage extends StatefulWidget {
  OnTheAirPage({Key? key}) : super(key: key);
  static const String routeName = '/on-the-air';
  @override
  _OnTheAirPageState createState() => _OnTheAirPageState();
}



class _OnTheAirPageState extends State<OnTheAirPage> {
  
@override
initState() {
  super.initState();
   Future.microtask(() =>
        Provider.of<OnTheAirTvNotifier>(context, listen: false)
            .fetchOnTheAirTv());
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('On The Air TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<OnTheAirTvNotifier>(
          builder: (context, data, child) {
            if (data.onTheAirState == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.onTheAirState == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = data.onTheAirTvList[index];
                  return TvCard(tv);
                },
                itemCount: data.onTheAirTvList.length,
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