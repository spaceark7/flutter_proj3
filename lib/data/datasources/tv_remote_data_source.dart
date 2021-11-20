import 'dart:convert';

import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/models/tv_model/tv_detail_model.dart';
import 'package:ditonton/data/models/tv_model/tv_model.dart';
import 'package:ditonton/data/models/tv_model/tv_response.dart';
import 'package:http/http.dart' as http;

abstract class TvRemoteDataSource {
  Future<List<TvSeriesModel>> getPopularTv();
  Future<List<TvSeriesModel>> getTopRatedTv();
  Future<List<TvSeriesModel>> getAiringTodayTv();
  Future<List<TvSeriesModel>> getOnTheAirTv();
  Future<List<TvSeriesModel>> getLatestTv();
  Future<List<TvSeriesModel>> searchTv(String query);
  Future<TvDetailModel> getTvDetail(int id);
}

class TvRemoteDataSourceImpl implements TvRemoteDataSource {
  static const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  static const BASE_URL = 'https://api.themoviedb.org/3';

  final http.Client client;

  TvRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TvSeriesModel>> getPopularTv() async {
    final response = await client.get(Uri.parse('$BASE_URL/tv/popular?api_key=$API_KEY'));
    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> getTopRatedTv() async {
    final response = await client.get(Uri.parse('$BASE_URL/tv/top_rated?api_key=$API_KEY'));
    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> getAiringTodayTv() async {
    final response = await client.get(Uri.parse('$BASE_URL/tv/airing_today?api_key=$API_KEY'));
    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> getOnTheAirTv() async {
    final response = await client.get(Uri.parse('$BASE_URL/tv/on_the_air?api_key=$API_KEY'));
    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TvDetailModel> getTvDetail(int id) async {
    final response = await client.get(Uri.parse('$BASE_URL/tv/$id?api_key=$API_KEY'));
    if (response.statusCode == 200) {
      return TvDetailModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> searchTv(String query) async {
    final response = await client.get(Uri.parse('$BASE_URL/search/tv?api_key=$API_KEY&query=$query'));
    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> getLatestTv() async {
    final response = await client.get(Uri.parse('$BASE_URL/tv/latest?api_key=$API_KEY'));
    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }
}
