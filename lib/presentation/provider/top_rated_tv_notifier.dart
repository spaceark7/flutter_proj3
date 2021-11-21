
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/TV%20Series/tv.dart';
import 'package:ditonton/domain/usecases/tv/get_top_rated.dart';
import 'package:flutter/cupertino.dart';

class TopRatedTvNotifier extends ChangeNotifier {

  var _topRatedTv = <TvSeries>[];
  List<TvSeries> get topRatedTv => this._topRatedTv;

  RequestState _topRatedTvState = RequestState.Empty;
  RequestState get topRatedTvState => this._topRatedTvState;

  String _message = '';
  String get message => this._message;

  final GetTopRatedTvs getTopRatedTvs;

  TopRatedTvNotifier({required this.getTopRatedTvs});


   Future<void> fetchTopRatedTv() async {
    _topRatedTvState = RequestState.Loading;
    notifyListeners();
    final result = await this.getTopRatedTvs.execute();
    result.fold((failure) {
      _topRatedTvState = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (tvdata) {
      _topRatedTvState = RequestState.Loaded;
      _topRatedTv = tvdata;
      notifyListeners();
    });
  }


}