import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/TV%20Series/tv.dart';
import 'package:ditonton/domain/entities/TV%20Series/tv_detail.dart';
import 'package:ditonton/common/failure.dart';

abstract class TvRepository {
  Future<Either<Failure, List<TvSeries>>> getPopularTv();
  Future<Either<Failure, List<TvSeries>>> getAiringToday();
  Future<Either<Failure, List<TvSeries>>> getOnTheAir();
  Future<Either<Failure, List<TvSeries>>> getTopRated();
  Future<Either<Failure, List<TvSeries>>> getTvLatest();
  Future<Either<Failure, List<TvSeries>>> searchTvSeries(String query);
  Future<Either<Failure, String>> saveWatchlist(TvDetail tv);
  Future<Either<Failure, String>> removeWatchlist(TvDetail tv);
  Future<bool> isAddedToWatchlist(int id);
  Future<Either<Failure, List<TvSeries>>> getTvSeries();
  Future<Either<Failure, TvDetail>> getTvDetail(int id);
  Future<Either<Failure, List<TvSeries>>> getWatchlistTv();
}
