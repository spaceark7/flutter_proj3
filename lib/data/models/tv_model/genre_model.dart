

import 'dart:convert';

import 'package:ditonton/domain/entities/genre.dart';
import 'package:equatable/equatable.dart';

class GenreModel extends Equatable {
    GenreModel({
        required this.id,
        required this.name,
    });

    final int id;
    final String name;

    factory GenreModel.fromRawJson(String str) => GenreModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory GenreModel.fromJson(Map<String, dynamic> json) => GenreModel(
        id: json["id"],
        name: json["name"],
    );

    Genre toEntity() {
        return Genre(
            id: this.id,
            name: this.name,
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };

    @override
    List<Object> get props => [id, name];
}