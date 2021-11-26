import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series/tv.dart';
import 'package:ditonton/domain/usecases/tv/get_watchlist_tv.dart';
import 'package:flutter/foundation.dart';

class WatchListTvNotifier extends ChangeNotifier {
  var _watchListTv = <TvSeries>[];
  List<TvSeries> get watchListTv => _watchListTv;

  RequestState _watchListTvState = RequestState.Empty;
  RequestState get watchListTvState => _watchListTvState;

  String _message = '';
  String get message => _message;

  WatchListTvNotifier({required this.getWatchlistTv});
  final GetWatchlistTv getWatchlistTv;

  Future<void> fetchWatchListTv() async {
    _watchListTvState = RequestState.Loading;
    notifyListeners();

    final result = await getWatchlistTv.execute();

    result.fold((failure) {
      _watchListTvState = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (tvData) {
      _watchListTvState = RequestState.Loaded;
      _watchListTv = tvData;
      notifyListeners();
    });
  }
}
