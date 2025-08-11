import 'package:final_subul_project/features/create_shipment/domain/entities/country_entity/country_entity.dart';

class CountryModel extends CountryEntity {
  int? id2;
  String? name2;
  String? code2;
  int? isEnabled;
  DateTime? createdAt;
  DateTime? updatedAt;

  CountryModel({
    this.id2,
    this.name2,
    this.code2,
    this.isEnabled,
    this.createdAt,
    this.updatedAt,
  }) : super(id: id2!, name: name2 ?? "No name", code: code2 ?? " No code");

  factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
    id2: json['id'] as int?,
    name2: json['name'] as String?,
    code2: json['code'] as String?,
    isEnabled: json['is_enabled'] as int?,
    createdAt:
        json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
    updatedAt:
        json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
  );

  Map<String, dynamic> toJson() => {
    'id': id2,
    'name': name2,
    'code': code2,
    'is_enabled': isEnabled,
    'created_at': createdAt?.toIso8601String(),
    'updated_at': updatedAt?.toIso8601String(),
  };
}
