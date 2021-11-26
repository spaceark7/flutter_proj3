import 'dart:convert';
import 'package:ditonton/domain/entities/tv_series/production_company.dart';
import 'package:equatable/equatable.dart';

class ProductionCompaniesModel extends Equatable {
    ProductionCompaniesModel({
        required this.name,
        required this.id,
        required this.logoPath,
        required this.originCountry,
    });

    final String name;
    final int id;
    final String? logoPath;
    final String originCountry;

    factory ProductionCompaniesModel.fromRawJson(String str) => ProductionCompaniesModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ProductionCompaniesModel.fromJson(Map<String, dynamic> json) => ProductionCompaniesModel(
        name: json["name"],
        id: json["id"],
        logoPath: json["logo_path"] == null ? null : json["logo_path"],
        originCountry: json["origin_country"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
        "logo_path": logoPath == null ? null : logoPath,
        "origin_country": originCountry,
    };

  ProductionCompany toEntity() {
    return ProductionCompany(
      name: this.name,
      id: this.id,
      logoPath: this.logoPath,
      originCountry: this.originCountry,
    );
  }

  @override
  List<Object?> get props => [name, id, logoPath, originCountry];
}