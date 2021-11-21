import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/TV%20Series/tv.dart';
import 'package:ditonton/domain/usecases/tv/get_popular_tv.dart';
import 'package:flutter/cupertino.dart';

class PopularTvNotifier extends ChangeNotifier {
  var _popularTv = <TvSeries>[];
  List<TvSeries> get popularTv => this._popularTv;

  RequestState _popularTvState = RequestState.Empty;
  RequestState get popularTvState => this._popularTvState;

  String _message = '';
  String get message => this._message;

  final GetPopularTvs getPopularTvs;

  PopularTvNotifier({required this.getPopularTvs});

  Future<void> fetchPopularTv() async {
    _popularTvState = RequestState.Loading;
    notifyListeners();
    final result = await this.getPopularTvs.execute();
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
