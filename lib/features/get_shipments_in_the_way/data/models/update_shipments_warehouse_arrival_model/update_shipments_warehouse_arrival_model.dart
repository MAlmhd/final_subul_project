import 'package:final_subul_project/features/get_shipments_in_the_way/domain/entity/update_shipments_warehouse_arrival_entity/update_shipments_warehouse_arrival_entity.dart';

import 'data.dart';

class UpdateShipmentsWarehouseArrivalModel
    extends UpdateShipmentsWarehouseArrivalEntity {
  bool? success;
  int? status;
  String? message2;
  Data? data;

  UpdateShipmentsWarehouseArrivalModel({
    this.success,
    this.status,
    this.message2,
    this.data,
  }) : super(message: message2!);

  factory UpdateShipmentsWarehouseArrivalModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return UpdateShipmentsWarehouseArrivalModel(
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
