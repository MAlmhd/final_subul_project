import 'package:final_subul_project/features/get_shipment_in_process/domain/entities/driver_entity/driver_entity.dart';

class DriverModel extends DriverEntity {
  int? id;
  String? name;

  DriverModel({this.id, this.name})
    : super(idDriver: id!, nameDriver: name ?? "");

  factory DriverModel.fromJson(Map<String, dynamic> json) =>
      DriverModel(id: json['id'] as int?, name: json['name'] as String?);

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}
