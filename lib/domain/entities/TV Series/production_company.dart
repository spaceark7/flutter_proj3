import 'package:equatable/equatable.dart';

class ProductionCompany extends Equatable {
  ProductionCompany({
    required this.name,
    required this.id,
    required this.logoPath,
    required this.originCountry,
  });

  String? name;
  int id;
  String? logoPath;
  String? originCountry;

  @override
  List<Object?> get props => [name, id, logoPath, originCountry];
}
