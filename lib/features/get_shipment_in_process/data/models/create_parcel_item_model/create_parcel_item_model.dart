import 'package:final_subul_project/features/get_shipment_in_process/domain/entities/create_parcel_item_entity/create_parcel_item_entity.dart';

import 'data.dart';

class CreateParcelItemModel extends CreateParcelItemEntity {
  bool? success;
  int? status;
  String? message2;
  Data? data;

  CreateParcelItemModel({this.success, this.status, this.message2, this.data})
    : super(message: message2!);

  factory CreateParcelItemModel.fromJson(Map<String, dynamic> json) {
    return CreateParcelItemModel(
      success: json['success'] as bool?,
      status: json['status'] as int?,
      message2: json['message']?.toString(), // هنا التحويل الآمن إلى String
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
