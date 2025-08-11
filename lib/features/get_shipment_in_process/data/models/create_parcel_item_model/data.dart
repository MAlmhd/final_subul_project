class Data {
	int? parcelId;
	String? itemType;
	int? quantity;
	int? valuePerItem;
	String? description;
	DateTime? updatedAt;
	DateTime? createdAt;
	int? id;

	Data({
		this.parcelId, 
		this.itemType, 
		this.quantity, 
		this.valuePerItem, 
		this.description, 
		this.updatedAt, 
		this.createdAt, 
		this.id, 
	});

	factory Data.fromJson(Map<String, dynamic> json) => Data(
  parcelId: int.tryParse(json['parcel_id'].toString()),
  itemType: json['item_type'] as String?,
  quantity: int.tryParse(json['quantity'].toString()),
  valuePerItem: int.tryParse(json['value_per_item'].toString()),
  description: json['description'] as String?,
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.tryParse(json['updated_at'].toString()),
  createdAt: json['created_at'] == null
      ? null
      : DateTime.tryParse(json['created_at'].toString()),
  id: int.tryParse(json['id'].toString()),
);


	Map<String, dynamic> toJson() => {
				'parcel_id': parcelId,
				'item_type': itemType,
				'quantity': quantity,
				'value_per_item': valuePerItem,
				'description': description,
				'updated_at': updatedAt?.toIso8601String(),
				'created_at': createdAt?.toIso8601String(),
				'id': id,
			};
}
