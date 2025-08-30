import 'package:final_subul_project/features/create_shipment/domain/entities/create_shipment_entity/create_shipment_entity.dart';

import 'data.dart';

class CreateShipmentModel extends CreateShipmentEntity{
	bool? success;
	int? status;
	String? message2;
	List<Data>? data; 

	CreateShipmentModel({this.success, this.status, this.message2, this.data}) : super(message: message2!);

	factory CreateShipmentModel.fromJson(Map<String, dynamic> json) {
		return CreateShipmentModel(
			success: json['success'] as bool?,
			status: json['status'] as int?,
			message2: json['message'] as String?,
			data: (json['data'] as List<dynamic>?)
          ?.map((e) => Data.fromJson(e as Map<String, dynamic>))
          .toList(),
		);
	}



	Map<String, dynamic> toJson() => {
				'success': success,
				'status': status,
				'message': message2,
				'data': data?.map((e) => e.toJson()).toList(),
			};
}
