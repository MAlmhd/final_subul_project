import 'package:final_subul_project/features/get_shipment_in_process/domain/entities/create_parcel_entity/create_parcel_entity.dart';

class CreateParcelModel extends CreateParcelEntity {
  bool? success;
  int? status;
  String? message;
  List<dynamic>? data;

  CreateParcelModel({this.success, this.status, this.message, this.data})
    : super(createdParcelMessage: message!);

  factory CreateParcelModel.fromJson(Map<String, dynamic> json) {
    return CreateParcelModel(
      success: json['success'] as bool?,
      status: json['status'] as int?,
      message: json['message'] as String?,
      data: json['data'] as List<dynamic>?,
    );
  }

  Map<String, dynamic> toJson() => {
    'success': success,
    'status': status,
    'message': message,
    'data': data,
  };
}
