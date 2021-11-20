import 'dart:convert';

class ProductionCountry {
    ProductionCountry({
        required this.iso31661,
        required this.name,
    });

    final String iso31661;
    final String name;

    factory ProductionCountry.fromRawJson(String str) => ProductionCountry.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ProductionCountry.fromJson(Map<String, dynamic> json) => ProductionCountry(
        iso31661: json["iso_3166_1"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "iso_3166_1": iso31661,
        "name": name,
    };
}