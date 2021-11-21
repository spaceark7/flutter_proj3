import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/TV%20Series/tv.dart';
import 'package:ditonton/domain/usecases/tv/get_airing_today.dart';
import 'package:flutter/foundation.dart';

class AiringTodayTvNotifier extends ChangeNotifier {
  final GetAiringTodayTvs getAiringTodayTvs;
  AiringTodayTvNotifier({required this.getAiringTodayTvs});

  RequestState _requestState = RequestState.Empty;
  RequestState get state => _requestState;

  List<TvSeries> _tvList = [];
  List<TvSeries> get tvList => _tvList;

  String _message = "";
  String get message => _message;

  Future<void> fetchAiringTodayTv() async {
    _requestState = RequestState.Loading;
    notifyListeners();

    final result = await getAiringTodayTvs.execute();
    result.fold((failure) {
      _requestState = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (tv) {
      _requestState = RequestState.Loaded;
       _tvList = tv; 
       notifyListeners();});
  }
}
