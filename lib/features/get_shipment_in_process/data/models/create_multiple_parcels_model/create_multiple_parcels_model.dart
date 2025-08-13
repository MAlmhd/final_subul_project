import 'package:final_subul_project/features/get_shipment_in_process/domain/entities/create_multiple_parcels_entity/create_multiple_parcels_entity.dart';

class CreateMultipleParcelsModel extends CreateMultipleParcelsEntity{
  bool? success;
  int? status;
  String? message2;
  Data? data;

  CreateMultipleParcelsModel({this.success, this.status, this.message2, this.data}) : super(message: message2!);

  factory CreateMultipleParcelsModel.fromJson(Map<String, dynamic> json) {
    return CreateMultipleParcelsModel(
      success: json['success'] as bool?,
      status: json['status'] as int?,
      message2: json['message'] as String?,
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'status': status,
      'message': message,
      'data': data?.toJson(),
    };
  }
}

class Data {
  String? shipmentId;
  List<CreatedParcel>? createdParcels;
  int? totalCreated;

  Data({this.shipmentId, this.createdParcels, this.totalCreated});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      shipmentId: json['shipment_id'] as String?,
      createdParcels: (json['created_parcels'] as List<dynamic>?)
          ?.map((e) => CreatedParcel.fromJson(e))
          .toList(),
      totalCreated: json['total_created'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'shipment_id': shipmentId,
      'created_parcels': createdParcels?.map((e) => e.toJson()).toList(),
      'total_created': totalCreated,
    };
  }
}

class CreatedParcel {
  Parcel? parcel;
  num? dimensionalWeight;
  num? finalWeight;

  CreatedParcel({this.parcel, this.dimensionalWeight, this.finalWeight});

  factory CreatedParcel.fromJson(Map<String, dynamic> json) {
    return CreatedParcel(
      parcel: json['parcel'] != null ? Parcel.fromJson(json['parcel']) : null,
      dimensionalWeight: json['dimensional_weight'] as num?, // بدل int?
      finalWeight: json['final_weight'] as num?,             // بدل int?
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'parcel': parcel?.toJson(),
      'dimensional_weight': dimensionalWeight,
      'final_weight': finalWeight,
    };
  }
}

class Parcel {
  int? id;
  String? shipmentId;
  String? actualWeight;
  String? length;
  String? width;
  String? height;
  String? brandType;
  bool? isFragile;
  bool? needsRepacking;
  String? notes;
  dynamic scalePhotoUpload;
  dynamic status;
  String? createdAt;
  String? updatedAt;

  Parcel({
    this.id,
    this.shipmentId,
    this.actualWeight,
    this.length,
    this.width,
    this.height,
    this.brandType,
    this.isFragile,
    this.needsRepacking,
    this.notes,
    this.scalePhotoUpload,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Parcel.fromJson(Map<String, dynamic> json) {
    return Parcel(
      id: json['id'] as int?,
      shipmentId: json['shipment_id'] as String?,
      actualWeight: json['actual_weight'] as String?,
      length: json['length'] as String?,
      width: json['width'] as String?,
      height: json['height'] as String?,
      brandType: json['brand_type'] as String?,
      isFragile: json['is_fragile'] as bool?,
      needsRepacking: json['needs_repacking'] as bool?,
      notes: json['notes'] as String?,
      scalePhotoUpload: json['scale_photo_upload'],
      status: json['status'],
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'shipment_id': shipmentId,
      'actual_weight': actualWeight,
      'length': length,
      'width': width,
      'height': height,
      'brand_type': brandType,
      'is_fragile': isFragile,
      'needs_repacking': needsRepacking,
      'notes': notes,
      'scale_photo_upload': scalePhotoUpload,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
