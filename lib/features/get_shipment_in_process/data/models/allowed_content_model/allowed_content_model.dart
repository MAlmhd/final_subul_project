import 'package:final_subul_project/features/get_shipment_in_process/domain/entities/allowed_content_entity/allowed_content_entity.dart';

class AllowedContentModel extends AllowedContentEntity {
  int? id2;
  String? content2;
  int? isAllowed;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  AllowedContentModel({
    this.id2,
    this.content2,
    this.isAllowed,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  }) : super(id: id2!, content: content2!);

  factory AllowedContentModel.fromJson(Map<String, dynamic> json) {
    return AllowedContentModel(
      id2: json['id'] as int?,
      content2: json['content'] as String?,
      isAllowed: json['is_allowed'] as int?,
      createdAt:
          json['created_at'] == null
              ? null
              : DateTime.parse(json['created_at'] as String),
      updatedAt:
          json['updated_at'] == null
              ? null
              : DateTime.parse(json['updated_at'] as String),
      deletedAt: json['deleted_at'] as dynamic,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id2,
    'content': content2,
    'is_allowed': isAllowed,
    'created_at': createdAt?.toIso8601String(),
    'updated_at': updatedAt?.toIso8601String(),
    'deleted_at': deletedAt,
  };
}
