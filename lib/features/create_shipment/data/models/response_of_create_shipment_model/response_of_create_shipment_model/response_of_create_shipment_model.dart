import 'package:final_subul_project/features/create_shipment/domain/entities/response_of_create_shipment_entity/response_of_create_shipment_entity.dart';

import 'data.dart';

class ResponseOfCreateShipmentModel extends ResponseOfCreateShipmentEntity {
  bool? success;
  int? status;
  String? message2;
  Data? data;

  ResponseOfCreateShipmentModel({
    this.success,
    this.status,
    this.message2,
    this.data,
  }) : super(message: message2!);

  factory ResponseOfCreateShipmentModel.fromJson(Map<String, dynamic> json) {
    return ResponseOfCreateShipmentModel(
      success: json['success'] as bool?,
      status: json['status'] as int?,
      message2: json['message'] as String?,
      data:
          json['data'] == null
              ? null
              : Data.fromJson(json['data'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
    'success': success,
    'status': status,
    'message': message2,
    'data': data?.toJson(),
  };
}
