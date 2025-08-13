import 'package:final_subul_project/features/get_deliverable_shipments/domain/entities/get_deliverable_shipments_entity/get_deliverable_shipments_entity.dart';

class GetDeliverableShipmentsModel extends GetDeliverableShipmentsEntity{
	String? customerName2;
	String? customerCode2;
	String? shipmentCreatedAt2;
	int? shipmentId2;
	String? trackingNumber2;

	GetDeliverableShipmentsModel({
		this.customerName2, 
		this.customerCode2, 
		this.shipmentCreatedAt2, 
		this.shipmentId2, 
		this.trackingNumber2, 
	}) : super(customerName: customerName2 ?? "", customerCode: customerCode2??"", shipmentCreatedAt: shipmentCreatedAt2 ?? "", shipmentId: shipmentId2!, trackingNumber: trackingNumber2 ?? "");

	factory GetDeliverableShipmentsModel.fromJson(Map<String, dynamic> json) {
		return GetDeliverableShipmentsModel(
			customerName2: json['customer_name'] as String?,
			customerCode2: json['customer_code'] as String?,
			shipmentCreatedAt2: json['shipment_created_at'] as String?,
			shipmentId2: json['shipment_id'] as int?,
			trackingNumber2: json['tracking_number'] as String?,
		);
	}



	Map<String, dynamic> toJson() => {
				'customer_name': customerName,
				'customer_code': customerCode,
				'shipment_created_at': shipmentCreatedAt,
				'shipment_id': shipmentId,
				'tracking_number': trackingNumber,
			};
}
