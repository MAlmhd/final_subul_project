import 'package:final_subul_project/features/sign_in/domain/entites/sign_in_entity.dart';

import 'data.dart';

class SignInModel extends SignInEntity{
	bool? success;
	int? status;
	String? message;
	Data? data;

	SignInModel({this.success, this.status, this.message, this.data}) : super(role: data?.role ?? "", token: data?.token ?? "");

	factory SignInModel.fromJson(Map<String, dynamic> json) => SignInModel(
				success: json['success'] as bool?,
				status: json['status'] as int?,
				message: json['message'] as String?,
				data: json['data'] == null
						? null
						: Data.fromJson(json['data'] as Map<String, dynamic>),
			);

	Map<String, dynamic> toJson() => {
				'success': success,
				'status': status,
				'message': message,
				'data': data?.toJson(),
			};
}
