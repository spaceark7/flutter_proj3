import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/TV%20Series/tv.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';

class GetLatestTvs {
  final TvRepository repository;

  GetLatestTvs(this.repository);

  Future<Either<Failure, List<TvSeries>>> execute() {
    return repository.getTvLatestTv();
  }
}
