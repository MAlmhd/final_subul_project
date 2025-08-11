import 'package:final_subul_project/features/get_shipment_in_process/domain/entities/get_parcel_items_entity/get_parcel_items_entity.dart';

class GetParcelItemsModel extends GetParcelItemsEntity {
  int? id2;
  int? parcelId2;
  String? itemType2;
  int? quantity2;
  String? valuePerItem2;
  String? description2;
  DateTime? createdAt;
  DateTime? updatedAt;

  GetParcelItemsModel({
    this.id2,
    this.parcelId2,
    this.itemType2,
    this.quantity2,
    this.valuePerItem2,
    this.description2,
    this.createdAt,
    this.updatedAt,
  }) : super(
         id: id2!,
         parcelId: parcelId2!,
         itemType: itemType2 ?? "",
         quantity: quantity2 ?? 0,
         valuePerItem: valuePerItem2 ?? "",
         description: description2 ?? "",
       );

  factory GetParcelItemsModel.fromJson(Map<String, dynamic> json) {
    return GetParcelItemsModel(
      id2: json['id'] as int?,
      parcelId2: json['parcel_id'] as int?,
      itemType2: json['item_type'] as String?,
      quantity2: json['quantity'] as int?,
      valuePerItem2: json['value_per_item'] as String?,
      description2: json['description'] as String?,
      createdAt:
          json['created_at'] == null
              ? null
              : DateTime.parse(json['created_at'] as String),
      updatedAt:
          json['updated_at'] == null
              ? null
              : DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id2,
    'parcel_id': parcelId2,
    'item_type': itemType2,
    'quantity': quantity2,
    'value_per_item': valuePerItem2,
    'description': description2,
    'created_at': createdAt?.toIso8601String(),
    'updated_at': updatedAt?.toIso8601String(),
  };
}
