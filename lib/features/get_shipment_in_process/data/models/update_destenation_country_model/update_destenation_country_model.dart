import 'package:final_subul_project/features/get_shipment_in_process/domain/entities/update_destenation_country_entity/update_destenation_country_entity.dart';

import 'data.dart';

class UpdateDestenationCountryModel extends UpdateDestenationCountryEntity {
  bool? success;
  int? status;
  String? message2;
  Data? data;

  UpdateDestenationCountryModel({
    this.success,
    this.status,
    this.message2,
    this.data,
  }) : super(message: message2!);

  factory UpdateDestenationCountryModel.fromJson(Map<String, dynamic> json) {
    return UpdateDestenationCountryModel(
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
