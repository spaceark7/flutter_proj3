

import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series/tv.dart';
import 'package:ditonton/domain/usecases/tv/get_on_the_air.dart';
import 'package:flutter/foundation.dart';

class OnTheAirTvNotifier extends ChangeNotifier {
  RequestState _onTheAirTvState = RequestState.Empty;
  RequestState get onTheAirState => _onTheAirTvState;


  List<TvSeries> _onTheAirTvList = [];
  List<TvSeries> get onTheAirTvList => _onTheAirTvList;

  final GetOnTheAirTvs getOnTheAirTvs;
  OnTheAirTvNotifier({required this.getOnTheAirTvs});

  String _message = "";
  String get message => _message;


   Future<void> fetchOnTheAirTv() async {
    _onTheAirTvState = RequestState.Loading;
    notifyListeners();
    final result = await this.getOnTheAirTvs.execute();
    result.fold((failure) {
      _onTheAirTvState = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (tvdata) {
      _onTheAirTvState = RequestState.Loaded;
      _onTheAirTvList = tvdata;
      notifyListeners();
    });
  }
}