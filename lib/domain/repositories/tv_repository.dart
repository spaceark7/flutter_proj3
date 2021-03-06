import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_series/tv.dart';
import 'package:ditonton/domain/entities/tv_series/tv_detail.dart';


abstract class TvRepository {
  Future<Either<Failure, List<TvSeries>>> getPopularTv();
  Future<Either<Failure, List<TvSeries>>> getAiringTodayTv();
  Future<Either<Failure, List<TvSeries>>> getOnTheAirTv();
  Future<Either<Failure, List<TvSeries>>> getTopRatedTv();
  Future<Either<Failure, List<TvSeries>>> searchTv(String query);
  Future<Either<Failure, String>> saveWatchlistTv(TvDetail tv);
  Future<Either<Failure, String>> removeWatchlistTv(TvDetail tv);
  Future<bool> isAddedToWatchlistTv(int id);
  Future<Either<Failure, TvDetail>> getTvDetail(int id);
  Future<Either<Failure, List<TvSeries>>> getTvRecommendations(int id);
  Future<Either<Failure, List<TvSeries>>> getWatchlistTv();
}
