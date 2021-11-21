import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/TV%20Series/tv.dart';
import 'package:ditonton/domain/usecases/tv/get_airing_today.dart';
import 'package:ditonton/domain/usecases/tv/get_on_the_air.dart';
import 'package:ditonton/domain/usecases/tv/get_popular_tv.dart';
import 'package:ditonton/domain/usecases/tv/get_top_rated.dart';
import 'package:flutter/cupertino.dart';

class TvListNotifier extends ChangeNotifier {
  var _airingTodayTv = <TvSeries>[];
  List<TvSeries> get airingTodayTv => this._airingTodayTv;

  RequestState _airingTodayTvState = RequestState.Empty;
  RequestState get airingTodayTvState => this._airingTodayTvState;

  var _onTheAirTv = <TvSeries>[];
  List<TvSeries> get onTheAirTv => this._onTheAirTv;

  RequestState _onTheAirTvState = RequestState.Empty;
  RequestState get onTheAirTvState => this._onTheAirTvState;

  var _topRatedTv = <TvSeries>[];
  List<TvSeries> get topRatedTv => this._topRatedTv;

  RequestState _topRatedTvState = RequestState.Empty;
  RequestState get topRatedTvState => this._topRatedTvState;

  var _popularTv = <TvSeries>[];
  List<TvSeries> get popularTv => this._popularTv;

  RequestState _popularTvState = RequestState.Empty;
  RequestState get popularTvState => this._popularTvState;

  String _message = '';
  String get message => this._message;

  TvListNotifier({
    required this.getAiringToday,
    required this.getOnTheAirTv,
    required this.getTopRatedTv,
    required this.getPopularTv,
  });

  final GetAiringTodayTvs getAiringToday;
  final GetOnTheAirTvs getOnTheAirTv;
  final GetPopularTvs getPopularTv;
  final GetTopRatedTvs getTopRatedTv;

  Future<void> fetchAiringTodayTv() async {
    _airingTodayTvState = RequestState.Loading;
    notifyListeners();
    final result = await this.getAiringToday.execute();
    result.fold((failure) {
      _airingTodayTvState = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (tvdata) {
      _airingTodayTvState = RequestState.Loaded;
      _airingTodayTv = tvdata;
      notifyListeners();
    });
  }

  Future<void> fetchOnTheAirTv() async {
    _onTheAirTvState = RequestState.Loading;
    notifyListeners();
    final result = await this.getOnTheAirTv.execute();
    result.fold((failure) {
      _onTheAirTvState = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (tvdata) {
      _onTheAirTvState = RequestState.Loaded;
      _onTheAirTv = tvdata;
      notifyListeners();
    });
  }

  Future<void> fetchTopRatedTv() async {
    _topRatedTvState = RequestState.Loading;
    notifyListeners();
    final result = await this.getTopRatedTv.execute();
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
  Future<void> fetchPopularTv() async {
    _popularTvState = RequestState.Loading;
    notifyListeners();
    final result = await this.getPopularTv.execute();
    result.fold((failure) {
      _popularTvState = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (tvdata) {
      _popularTvState = RequestState.Loaded;
      _popularTv = tvdata;
      notifyListeners();
    });
  }
}
