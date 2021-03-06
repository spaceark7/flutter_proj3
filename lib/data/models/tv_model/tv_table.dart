


import 'package:ditonton/domain/entities/tv_series/tv.dart';
import 'package:ditonton/domain/entities/tv_series/tv_detail.dart';
import 'package:equatable/equatable.dart';

class TvTable extends Equatable {
  final int id;
  final String? name;
  final String? posterPath;
  final String? overview;

  TvTable({
    required this.id,
    required this.name,
    required this.posterPath,
    required this.overview,
  });
  
  factory TvTable.fromEntity(TvDetail tv) {
    return TvTable(
      id: tv.id,
      name: tv.name,
      posterPath: tv.posterPath,
      overview: tv.overview,
    );
  }

  factory TvTable.fromMap(Map<String, dynamic> map) {
    return TvTable(
      id: map['id'],
      name: map['name'],
      posterPath: map['posterPath'],
      overview: map['overview'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'posterPath': posterPath,
      'overview': overview,
    };
  }

  TvSeries toEntity() => TvSeries.watchlist(
        id: id,
        name: name,
        posterPath: posterPath,
        overview: overview,
      );
     
  
  @override
  List<Object?> get props => [id, name, posterPath, overview];

}