import 'package:image_picker/image_picker.dart';

class ParcelItemRequest {
  final String itemType;
  final int quantity;
  final num valuePerItem;
  final String? description;

  ParcelItemRequest({
    required this.itemType,
    required this.quantity,
    required this.valuePerItem,
    this.description,
  });

  Map<String, dynamic> toJson() => {
    "item_type": itemType,
    "quantity": quantity,
    "value_per_item": valuePerItem,
    if (description != null && description!.isNotEmpty)
      "description": description,
  };
}

class ParcelRequest {
  final num actualWeight;
  final num length;
  final num width;
  final num height;
  final String? brandType;
  final bool isFragile;
  final bool needsRepacking;
  final String? notes;
  final XFile scaledPhoto;
  final List<ParcelItemRequest> items;

  ParcelRequest({
    required this.scaledPhoto,
    required this.actualWeight,
    required this.length,
    required this.width,
    required this.height,
    this.brandType,
    required this.isFragile,
    required this.needsRepacking,
    this.notes,
    required this.items,
  });

  Map<String, dynamic> toJson() => {
    "actual_weight": actualWeight,
    "length": length,
    "width": width,
    "height": height,
    if (brandType != null && brandType!.isNotEmpty) "brand_type": brandType,
    "is_fragile": isFragile,
    "needs_repacking": needsRepacking,
    if (notes != null && notes!.isNotEmpty) "notes": notes,
    "items": items.map((e) => e.toJson()).toList(),
  };
}

class CreateMultipleParcelsBody {
  final List<ParcelRequest> parcels;

  CreateMultipleParcelsBody(this.parcels);

  Map<String, dynamic> toJson() => {
    "parcels": parcels.map((p) => p.toJson()).toList(),
  };
}
