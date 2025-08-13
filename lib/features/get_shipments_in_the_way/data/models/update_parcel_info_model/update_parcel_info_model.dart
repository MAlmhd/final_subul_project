import 'package:final_subul_project/features/get_shipments_in_the_way/domain/entity/update_parcel_info_entity/update_parcel_info_entity.dart';

import 'data.dart';

class UpdateParcelInfoModel extends UpdateParcelInfoEntity{
	bool? success;
	int? status;
	String? message;
	Data? data;

	UpdateParcelInfoModel({
		this.success, 
		this.status, 
		this.message, 
		this.data, 
	}) : super(messageUpdate: message!);

	factory UpdateParcelInfoModel.fromJson(Map<String, dynamic> json) {
		return UpdateParcelInfoModel(
			success: json['success'] as bool?,
			status: json['status'] as int?,
			message: json['message'] as String?,
			data: json['data'] == null
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
