import 'package:final_subul_project/features/create_shipment/domain/entities/user_entity/user_entity.dart';

class UserModel extends UserEntity {
  int? id2;
  String? role;
  dynamic parentCompanyId;
  String? firstName2;
  String? lastName2;
  String? email;
  String? phone;
  DateTime? phoneVerifiedAt;
  String? gender;
  String? address;
  int? status;
  String? timezone;
  dynamic profilePhotoPath;
  dynamic identityPhotoPath;
  String? customerCode;
  dynamic fcmToken;
  dynamic verifiedCode;
  DateTime? emailVerifiedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  UserModel({
    this.id2,
    this.role,
    this.parentCompanyId,
    this.firstName2,
    this.lastName2,
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
  }) : super(
         firstName: firstName2 ?? "No first name",
         lastName: lastName2 ?? "No last name",
         id: id2!,
       );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id2: json['id'] as int?,
    role: json['role'] as String?,
    parentCompanyId: json['parent_company_id'] as dynamic,
    firstName2: json['first_name'] as String?,
    lastName2: json['last_name'] as String?,
    email: json['email'] as String?,
    phone: json['phone'] as String?,
    phoneVerifiedAt:
        json['phone_verified_at'] == null
            ? null
            : DateTime.parse(json['phone_verified_at'] as String),
    gender: json['gender'] as String?,
    address: json['address'] as String?,
    status: json['status'] as int?,
    timezone: json['timezone'] as String?,
    profilePhotoPath: json['profile_photo_path'] as dynamic,
    identityPhotoPath: json['identity_photo_path'] as dynamic,
    customerCode: json['customer_code'] as String?,
    fcmToken: json['FCM_TOKEN'] as dynamic,
    verifiedCode: json['verified_code'] as dynamic,
    emailVerifiedAt:
        json['email_verified_at'] == null
            ? null
            : DateTime.parse(json['email_verified_at'] as String),
    createdAt:
        json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
    updatedAt:
        json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
    deletedAt: json['deleted_at'] as dynamic,
  );

  Map<String, dynamic> toJson() => {
    'id': id2,
    'role': role,
    'parent_company_id': parentCompanyId,
    'first_name': firstName2,
    'last_name': lastName2,
    'email': email,
    'phone': phone,
    'phone_verified_at': phoneVerifiedAt?.toIso8601String(),
    'gender': gender,
    'address': address,
    'status': status,
    'timezone': timezone,
    'profile_photo_path': profilePhotoPath,
    'identity_photo_path': identityPhotoPath,
    'customer_code': customerCode,
    'FCM_TOKEN': fcmToken,
    'verified_code': verifiedCode,
    'email_verified_at': emailVerifiedAt?.toIso8601String(),
    'created_at': createdAt?.toIso8601String(),
    'updated_at': updatedAt?.toIso8601String(),
    'deleted_at': deletedAt,
  };
}
