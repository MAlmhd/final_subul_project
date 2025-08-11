class Data {
	int? id;
	String? trackingNumber;
	String? type;
	int? customerId;
	int? supplierId;
	String? supplierName;
	String? supplierNumber;
	int? originCountryId;
	int? destinationCountryId;
	int? deliveryStaffId;
	String? status;
	int? declaredParcelsCount;
	int? actualParcelsCount;
	String? sentAt;
	String? deliveredAt;
	String? warehouseReceivedAt;
	int? warehouseReceiverId;
	String? cancellationReason;
	String? notes;
	int? createdByUserId;
	int? isApproved;
	int? markAsDelivered;
	int? deliveredToWhDis;
	dynamic longitude;
	dynamic latitude;
	String? shipmentPhoto;
	dynamic scalePhoto;
	dynamic airportReceiptPhoto;
	DateTime? createdAt;
	DateTime? updatedAt;
	dynamic deletedAt;

	Data({
		this.id, 
		this.trackingNumber, 
		this.type, 
		this.customerId, 
		this.supplierId, 
		this.supplierName, 
		this.supplierNumber, 
		this.originCountryId, 
		this.destinationCountryId, 
		this.deliveryStaffId, 
		this.status, 
		this.declaredParcelsCount, 
		this.actualParcelsCount, 
		this.sentAt, 
		this.deliveredAt, 
		this.warehouseReceivedAt, 
		this.warehouseReceiverId, 
		this.cancellationReason, 
		this.notes, 
		this.createdByUserId, 
		this.isApproved, 
		this.markAsDelivered, 
		this.deliveredToWhDis, 
		this.longitude, 
		this.latitude, 
		this.shipmentPhoto, 
		this.scalePhoto, 
		this.airportReceiptPhoto, 
		this.createdAt, 
		this.updatedAt, 
		this.deletedAt, 
	});

	factory Data.fromJson(Map<String, dynamic> json) => Data(
				id: json['id'] as int?,
				trackingNumber: json['tracking_number'] as String?,
				type: json['type'] as String?,
				customerId: json['customer_id'] as int?,
				supplierId: json['supplier_id'] as int?,
				supplierName: json['supplier_name'] as String?,
				supplierNumber: json['supplier_number'] as String?,
				originCountryId: json['origin_country_id'] as int?,
				destinationCountryId: json['destination_country_id'] as int?,
				deliveryStaffId: json['delivery_staff_id'] as int?,
				status: json['status'] as String?,
				declaredParcelsCount: json['declared_parcels_count'] as int?,
				actualParcelsCount: json['actual_parcels_count'] as int?,
				sentAt: json['sent_at'] as String?,
				deliveredAt: json['delivered_at'] as String?,
				warehouseReceivedAt: json['warehouse_received_at'] as String?,
				warehouseReceiverId: json['warehouse_receiver_id'] as int?,
				cancellationReason: json['cancellation_reason'] as String?,
				notes: json['notes'] as String?,
				createdByUserId: json['created_by_user_id'] as int?,
				isApproved: json['is_approved'] as int?,
				markAsDelivered: json['mark_as_delivered'] as int?,
				deliveredToWhDis: json['delivered_to_WH_dis'] as int?,
				longitude: json['longitude'] as dynamic,
				latitude: json['latitude'] as dynamic,
				shipmentPhoto: json['shipment_photo'] as String?,
				scalePhoto: json['scale_photo'] as dynamic,
				airportReceiptPhoto: json['airport_receipt_photo'] as dynamic,
				createdAt: json['created_at'] == null
						? null
						: DateTime.parse(json['created_at'] as String),
				updatedAt: json['updated_at'] == null
						? null
						: DateTime.parse(json['updated_at'] as String),
				deletedAt: json['deleted_at'] as dynamic,
			);

	Map<String, dynamic> toJson() => {
				'id': id,
				'tracking_number': trackingNumber,
				'type': type,
				'customer_id': customerId,
				'supplier_id': supplierId,
				'supplier_name': supplierName,
				'supplier_number': supplierNumber,
				'origin_country_id': originCountryId,
				'destination_country_id': destinationCountryId,
				'delivery_staff_id': deliveryStaffId,
				'status': status,
				'declared_parcels_count': declaredParcelsCount,
				'actual_parcels_count': actualParcelsCount,
				'sent_at': sentAt,
				'delivered_at': deliveredAt,
				'warehouse_received_at': warehouseReceivedAt,
				'warehouse_receiver_id': warehouseReceiverId,
				'cancellation_reason': cancellationReason,
				'notes': notes,
				'created_by_user_id': createdByUserId,
				'is_approved': isApproved,
				'mark_as_delivered': markAsDelivered,
				'delivered_to_WH_dis': deliveredToWhDis,
				'longitude': longitude,
				'latitude': latitude,
				'shipment_photo': shipmentPhoto,
				'scale_photo': scalePhoto,
				'airport_receipt_photo': airportReceiptPhoto,
				'created_at': createdAt?.toIso8601String(),
				'updated_at': updatedAt?.toIso8601String(),
				'deleted_at': deletedAt,
			};
}
