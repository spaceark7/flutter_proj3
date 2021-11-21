import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/TV%20Series/tv.dart';
import 'package:ditonton/domain/entities/TV%20Series/tv_detail.dart';
import 'package:ditonton/domain/usecases/tv/get_tv_detail.dart';
import 'package:ditonton/domain/usecases/tv/get_tv_recommendations.dart';
import 'package:ditonton/domain/usecases/tv/get_watchlist_tv_status.dart';
import 'package:ditonton/domain/usecases/tv/remove_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/tv/save_watchlist_tv.dart';
import 'package:flutter/cupertino.dart';

class TvDetailNotifier extends ChangeNotifier {
  static const watchlistAddSuccessMessage = "Tv Series Added To Watchlist";
  static const watchlistRemoveSuccessMessage = "Tv Series Removed From Watchlist";

  final GetTvDetail getTvDetail;
  final GetTvRecommendations getTvRecommendations;
  final GetWatchListTvStatus getWatchListTvStatus;
  final SaveWatchlistTv saveWatchlistTv;
  final RemoveWatchlistTv removeWatchlistTv;

  TvDetailNotifier({
    required this.getTvDetail,
    required this.getTvRecommendations,
    required this.getWatchListTvStatus,
    required this.saveWatchlistTv,
    required this.removeWatchlistTv,
  });

  late TvDetail _tvDetail;
  TvDetail get tvDetail => _tvDetail;

  RequestState _tvState = RequestState.Empty;
  RequestState get tvState => _tvState;

  List<TvSeries> _tvRecommendations = [];
  List<TvSeries> get tvRecommendations => _tvRecommendations;

  RequestState _tvRecommendationsState = RequestState.Empty;
  RequestState get tvRecommendationsState => _tvRecommendationsState;

  String _message = '';
  String get message => _message;

  bool _isAddedToWatchlist = false;
  bool get isAddedToWatchlist => _isAddedToWatchlist;

  Future<void> fetchTvDetail(int id) async {
    _tvState = RequestState.Loading;
    notifyListeners();

    final detailResult = await getTvDetail.execute(id);
    final recommendationResult = await getTvRecommendations.execute(id);

    detailResult.fold((failure) {
      _tvState = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (tvData) {
      _tvRecommendationsState = RequestState.Loading;
      _tvDetail = tvData;
      notifyListeners();
      recommendationResult.fold((failure) {
        _tvRecommendationsState = RequestState.Error;
        _message = failure.message;
      }, (tvRecommendations) {
        _tvRecommendationsState = RequestState.Loaded;
        _tvRecommendations = tvRecommendations;
      });
      _tvState = RequestState.Loaded;
      notifyListeners();
    });
  }

  String _watchlistMessage = '';
  String get watchlistMessage => _watchlistMessage;

  Future<void> addWatchListTv(TvDetail tv) async {
    final result = await saveWatchlistTv.execute(tv);
    await result.fold((failure) async {
      _watchlistMessage = failure.message;
    }, (successMessage) async {
      _watchlistMessage = successMessage;
    });

    await loadWatchlistStatus(tv.id);
  }

  Future<void> removeFromWatchlistTv(TvDetail tv) async {
    final result = await removeWatchlistTv.execute(tv);
    await result.fold((failure) async {
      _watchlistMessage = failure.message;
    }, (successMessage) async {
      _watchlistMessage = successMessage;
    });

    await loadWatchlistStatus(tv.id);
  }

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getWatchListTvStatus.execute(id);
    _isAddedToWatchlist = result;
    notifyListeners();
  }
}
