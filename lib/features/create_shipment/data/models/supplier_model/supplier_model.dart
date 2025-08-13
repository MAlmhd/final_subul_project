import 'package:final_subul_project/features/create_shipment/domain/entities/supplier_entity/supplier_entity.dart';

class SupplierModel extends SupplierEntity{
	int? id;
	String? name;
	String? phone;
	String? email;
	String? address;
	DateTime? createdAt;
	DateTime? updatedAt;

	SupplierModel({
		this.id, 
		this.name, 
		this.phone, 
		this.email, 
		this.address, 
		this.createdAt, 
		this.updatedAt, 
	}) : super(supplierId: id!, supplierName: name ?? "", supplierPhoneNumber: phone ?? "", supplieremail: email ?? "", supplierAddress: address ?? "");

	factory SupplierModel.fromJson(Map<String, dynamic> json) => SupplierModel(
				id: json['id'] as int?,
				name: json['name'] as String?,
				phone: json['phone'] as String?,
				email: json['email'] as String?,
				address: json['address'] as String?,
				createdAt: json['created_at'] == null
						? null
						: DateTime.parse(json['created_at'] as String),
				updatedAt: json['updated_at'] == null
						? null
						: DateTime.parse(json['updated_at'] as String),
			);

	Map<String, dynamic> toJson() => {
				'id': id,
				'name': name,
				'phone': phone,
				'email': email,
				'address': address,
				'created_at': createdAt?.toIso8601String(),
				'updated_at': updatedAt?.toIso8601String(),
			};
}
