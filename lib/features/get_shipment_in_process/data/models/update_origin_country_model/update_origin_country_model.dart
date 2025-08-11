import 'package:final_subul_project/features/get_shipment_in_process/domain/entities/update_origin_country_entity/update_origin_country_entity.dart';

import 'data.dart';

class UpdateOriginCountryModel extends UpdateOriginCountryEntity {
  bool? success;
  int? status;
  String? message;
  Data? data;

  UpdateOriginCountryModel({this.success, this.status, this.message, this.data})
    : super(messageOfUpdating: message!);

  factory UpdateOriginCountryModel.fromJson(Map<String, dynamic> json) {
    return UpdateOriginCountryModel(
      success: json['success'] as bool?,
      status: json['status'] as int?,
      message: json['message'] as String?,
      data:
          json['data'] == null
              ? null
              : Data.fromJson(json['data'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
    'success': success,
    'status': status,
    'message': message,
    'data': data?.toJson(),
  };
}
