import 'package:final_subul_project/features/get_deliverable_shipments/domain/entities/mark_shipment_delivered_entity/mark_shipment_delivered_entity.dart';

import 'data.dart';

class MarkShipmentDeliveredModel extends MarkShipmentDeliveredEntity{
	bool? success;
	int? status;
	String? message2;
	Data? data;

	MarkShipmentDeliveredModel({
		this.success, 
		this.status, 
		this.message2, 
		this.data, 
	}) : super(message: message2??"");

	factory MarkShipmentDeliveredModel.fromJson(Map<String, dynamic> json) {
		return MarkShipmentDeliveredModel(
			success: json['success'] as bool?,
			status: json['status'] as int?,
			message2: json['message'] as String?,
			data: json['data'] == null
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
