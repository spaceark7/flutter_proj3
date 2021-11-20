import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/data/datasources/tv_local_data_source.dart';
import 'package:ditonton/data/datasources/tv_remote_data_source.dart';
import 'package:ditonton/data/models/tv_model/tv_table.dart';
import 'package:ditonton/domain/entities/TV%20Series/tv.dart';
import 'package:ditonton/domain/entities/TV%20Series/tv_detail.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';

class TvRepositoryImpl implements TvRepository {
  final TvLocalDataSource tvLocalDataSource;
  final TvRemoteDataSource tvRemoteDataSource;

  TvRepositoryImpl({required this.tvLocalDataSource, required this.tvRemoteDataSource});

  @override
  Future<Either<Failure, List<TvSeries>>> getPopularTv() async {
    try {
      final result = await tvRemoteDataSource.getPopularTv();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure('Server Not Responding'));
    } on SocketException {
      return Left(ConnectionFailure('Failed To Connect to Network'));
    }
  }

  @override
  Future<Either<Failure, List<TvSeries>>> getTopRatedTv() async {
    try {
      final result = await tvRemoteDataSource.getTopRatedTv();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure('Server Not Responding'));
    } on SocketException {
      return Left(ConnectionFailure('Failed To Connect to Network'));
    }
  }

  @override
  Future<Either<Failure, List<TvSeries>>> getAiringTodayTv() async {
    try {
      final result = await tvRemoteDataSource.getAiringTodayTv();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure('Server Not Responding'));
    } on SocketException {
      return Left(ConnectionFailure('Failed To Connect to Network'));
    }
  }

  @override
  Future<Either<Failure, List<TvSeries>>> getOnTheAirTv() async {
    try {
      final result = await tvRemoteDataSource.getOnTheAirTv();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure('Server Not Responding'));
    } on SocketException {
      return Left(ConnectionFailure('Failed To Connect to Network'));
    }
  }
  


  @override
  Future<Either<Failure, TvDetail>> getTvDetail(int id) async {
    try {
      final result = await tvRemoteDataSource.getTvDetail(id);
      return Right(result.toEntity());
    } on ServerException {
      return Left(ServerFailure('Server Not Responding'));
    } on SocketException {
      return Left(ConnectionFailure('Failed To Connect to Network'));
    }
  }


  @override
  Future<Either<Failure, List<TvSeries>>> searchTv(String query) async {
    try {
      final result = await tvRemoteDataSource.searchTv(query);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure('Server Not Responding'));
    } on SocketException {
      return Left(ConnectionFailure('Failed To Connect to Network'));
    }
  }

  @override
  Future<Either<Failure, List<TvSeries>>> getWatchlistTvs() async {
    final result = await tvLocalDataSource.getWatchlistTvs();
    return Right(result.map((model) => model.toEntity()).toList());
  }

  @override
  Future<bool> isAddedToWatchlistTv(int id) async {
    final result = await tvLocalDataSource.getTvById(id);
    return result != null;
  }

  @override
  Future<Either<Failure, String>> removeWatchlistTv(TvDetail tv) async {
    try {
      final result = await tvLocalDataSource.removeWatchlistTv(TvTable.fromEntity(tv));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> saveWatchlistTv(TvDetail tv) async {
    try {
      final result = await tvLocalDataSource.insertWatchlistTv(TvTable.fromEntity(tv));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      throw e;
    }
  }
}
