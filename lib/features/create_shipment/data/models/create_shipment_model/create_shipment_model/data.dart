class Data {
	String? type;
	String? customerId;
	String? supplierId;
	String? originCountryId;
	String? destinationCountryId;
	String? declaredParcelsCount;
	String? notes;
	dynamic status;
	int? createdByUserId;
	String? trackingNumber;
	bool? isApproved;
	DateTime? updatedAt;
	DateTime? createdAt;
	int? id;

	Data({
		this.type, 
		this.customerId, 
		this.supplierId, 
		this.originCountryId, 
		this.destinationCountryId, 
		this.declaredParcelsCount, 
		this.notes, 
		this.status, 
		this.createdByUserId, 
		this.trackingNumber, 
		this.isApproved, 
		this.updatedAt, 
		this.createdAt, 
		this.id, 
	});
factory Data.fromJson(Map<String, dynamic> json) => Data(
  type: json['type']?.toString(),
  customerId: json['customer_id']?.toString(),
  supplierId: json['supplier_id']?.toString(),
  originCountryId: json['origin_country_id']?.toString(),
  destinationCountryId: json['destination_country_id']?.toString(),
  declaredParcelsCount: json['declared_parcels_count']?.toString(),
  notes: json['notes']?.toString(),
  status: json['status'],
  createdByUserId: json['created_by_user_id'] as int?,
  trackingNumber: json['tracking_number']?.toString(),
  isApproved: json['is_approved'] as bool?,
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'].toString()),
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'].toString()),
  id: json['id'] as int?,
);

	Map<String, dynamic> toJson() => {
				'type': type,
				'customer_id': customerId,
				'supplier_id': supplierId,
				'origin_country_id': originCountryId,
				'destination_country_id': destinationCountryId,
				'declared_parcels_count': declaredParcelsCount,
				'notes': notes,
				'status': status,
				'created_by_user_id': createdByUserId,
				'tracking_number': trackingNumber,
				'is_approved': isApproved,
				'updated_at': updatedAt?.toIso8601String(),
				'created_at': createdAt?.toIso8601String(),
				'id': id,
			};
}
