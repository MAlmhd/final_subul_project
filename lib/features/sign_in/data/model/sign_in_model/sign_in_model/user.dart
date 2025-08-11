class User {
	int? id;
	String? role;
	dynamic parentCompanyId;
	String? firstName;
	String? lastName;
	String? email;
	dynamic phone;
	dynamic phoneVerifiedAt;
	dynamic gender;
	dynamic address;
	int? status;
	dynamic timezone;
	dynamic profilePhotoPath;
	dynamic identityPhotoPath;
	dynamic customerCode;
	dynamic fcmToken;
	dynamic verifiedCode;
	dynamic emailVerifiedAt;
	DateTime? createdAt;
	DateTime? updatedAt;
	dynamic deletedAt;

	User({
		this.id, 
		this.role, 
		this.parentCompanyId, 
		this.firstName, 
		this.lastName, 
		this.email, 
		this.phone, 
		this.phoneVerifiedAt, 
		this.gender, 
		this.address, 
		this.status, 
		this.timezone, 
		this.profilePhotoPath, 
		this.identityPhotoPath, 
		this.customerCode, 
		this.fcmToken, 
		this.verifiedCode, 
		this.emailVerifiedAt, 
		this.createdAt, 
		this.updatedAt, 
		this.deletedAt, 
	});

	factory User.fromJson(Map<String, dynamic> json) => User(
				id: json['id'] as int?,
				role: json['role'] as String?,
				parentCompanyId: json['parent_company_id'] as dynamic,
				firstName: json['first_name'] as String?,
				lastName: json['last_name'] as String?,
				email: json['email'] as String?,
				phone: json['phone'] as dynamic,
				phoneVerifiedAt: json['phone_verified_at'] as dynamic,
				gender: json['gender'] as dynamic,
				address: json['address'] as dynamic,
				status: json['status'] as int?,
				timezone: json['timezone'] as dynamic,
				profilePhotoPath: json['profile_photo_path'] as dynamic,
				identityPhotoPath: json['identity_photo_path'] as dynamic,
				customerCode: json['customer_code'] as dynamic,
				fcmToken: json['FCM_TOKEN'] as dynamic,
				verifiedCode: json['verified_code'] as dynamic,
				emailVerifiedAt: json['email_verified_at'] as dynamic,
				createdAt: json['created_at'] == null
						? null
						: DateTime.parse(json['created_at'] as String),
				updatedAt: json['updated_at'] == null
						? null
						: DateTime.parse(json['updated_at'] as String),
				deletedAt: json['deleted_at'] as dynamic,
			);

	Map<String, dynamic> toJson() => {
				'id': id,
				'role': role,
				'parent_company_id': parentCompanyId,
				'first_name': firstName,
				'last_name': lastName,
				'email': email,
				'phone': phone,
				'phone_verified_at': phoneVerifiedAt,
				'gender': gender,
				'address': address,
				'status': status,
				'timezone': timezone,
				'profile_photo_path': profilePhotoPath,
				'identity_photo_path': identityPhotoPath,
				'customer_code': customerCode,
				'FCM_TOKEN': fcmToken,
				'verified_code': verifiedCode,
				'email_verified_at': emailVerifiedAt,
				'created_at': createdAt?.toIso8601String(),
				'updated_at': updatedAt?.toIso8601String(),
				'deleted_at': deletedAt,
			};
}
