class Data {
	int? id;
	int? shipmentId;
	String? actualWeight;
	String? length;
	String? width;
	String? height;
	dynamic scalePhotoUpload;
	String? updatedScalePhotoUpload;
	dynamic declaredItemsCount;
	String? brandType;
	int? isFragile;
	int? needsRepacking;
	String? status;
	dynamic contentDescription;
	String? notes;
	dynamic printNotes;
	dynamic airportReceiptPath;
	int? isOpened;
	String? openedNotes;
	int? isDamaged;
	String? damagedNotes;
	String? newActualWeight;
	DateTime? createdAt;
	DateTime? updatedAt;
	dynamic deletedAt;

	Data({
		this.id, 
		this.shipmentId, 
		this.actualWeight, 
		this.length, 
		this.width, 
		this.height, 
		this.scalePhotoUpload, 
		this.updatedScalePhotoUpload, 
		this.declaredItemsCount, 
		this.brandType, 
		this.isFragile, 
		this.needsRepacking, 
		this.status, 
		this.contentDescription, 
		this.notes, 
		this.printNotes, 
		this.airportReceiptPath, 
		this.isOpened, 
		this.openedNotes, 
		this.isDamaged, 
		this.damagedNotes, 
		this.newActualWeight, 
		this.createdAt, 
		this.updatedAt, 
		this.deletedAt, 
	});

	factory Data.fromJson(Map<String, dynamic> json) => Data(
				id: json['id'] as int?,
				shipmentId: json['shipment_id'] as int?,
				actualWeight: json['actual_weight'] as String?,
				length: json['length'] as String?,
				width: json['width'] as String?,
				height: json['height'] as String?,
				scalePhotoUpload: json['scale_photo_upload'] as dynamic,
				updatedScalePhotoUpload: json['updated_scale_photo_upload'] as String?,
				declaredItemsCount: json['declared_items_count'] as dynamic,
				brandType: json['brand_type'] as String?,
				isFragile: json['is_fragile'] as int?,
				needsRepacking: json['needs_repacking'] as int?,
				status: json['status'] as String?,
				contentDescription: json['content_description'] as dynamic,
				notes: json['notes'] as String?,
				printNotes: json['print_notes'] as dynamic,
				airportReceiptPath: json['airport_receipt_path'] as dynamic,
				isOpened: json['is_opened'] as int?,
				openedNotes: json['opened_notes'] as String?,
				isDamaged: json['is_damaged'] as int?,
				damagedNotes: json['damaged_notes'] as String?,
				newActualWeight: json['new_actual_weight'] as String?,
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
				'shipment_id': shipmentId,
				'actual_weight': actualWeight,
				'length': length,
				'width': width,
				'height': height,
				'scale_photo_upload': scalePhotoUpload,
				'updated_scale_photo_upload': updatedScalePhotoUpload,
				'declared_items_count': declaredItemsCount,
				'brand_type': brandType,
				'is_fragile': isFragile,
				'needs_repacking': needsRepacking,
				'status': status,
				'content_description': contentDescription,
				'notes': notes,
				'print_notes': printNotes,
				'airport_receipt_path': airportReceiptPath,
				'is_opened': isOpened,
				'opened_notes': openedNotes,
				'is_damaged': isDamaged,
				'damaged_notes': damagedNotes,
				'new_actual_weight': newActualWeight,
				'created_at': createdAt?.toIso8601String(),
				'updated_at': updatedAt?.toIso8601String(),
				'deleted_at': deletedAt,
			};
}
