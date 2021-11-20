import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/TV%20Series/tv.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';

class SearchTvSeries {
  final TvRepository repository;

  SearchTvSeries(this.repository);

  Future<Either<Failure, List<TvSeries>>> execute(String query) {
    return repository.searchTv(query);
  }
}
