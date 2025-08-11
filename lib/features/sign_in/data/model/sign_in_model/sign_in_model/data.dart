import 'user.dart';

class Data {
	User? user;
	String? role;
	String? token;

	Data({this.user, this.role, this.token});

	factory Data.fromJson(Map<String, dynamic> json) => Data(
				user: json['user'] == null
						? null
						: User.fromJson(json['user'] as Map<String, dynamic>),
				role: json['role'] as String?,
				token: json['token'] as String?,
			);

	Map<String, dynamic> toJson() => {
				'user': user?.toJson(),
				'role': role,
				'token': token,
			};
}
