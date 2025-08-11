import 'package:final_subul_project/features/get_all_parcels/domain/entities/parcel_entity/parcel_entity.dart';

class GetAllParcelsModel extends ParcelEntity {
  int? id2;
  int? shipmentId2;
  String? actualWeight2;
  String? specialActualWeight2;
  dynamic normalActualWeight2;
  dynamic specialDimensionalWeight2;
  dynamic normalDimensionalWeight2;
  String? length2;
  String? width2;
  String? height2;
  String? calculatedDimensionalWeight2;
  String? calculatedFinalWeight2;
  int? customerId2;
  String? firstName2;
  String? lastName2;

  GetAllParcelsModel({
    this.id2,
    this.shipmentId2,
    this.actualWeight2,
    this.specialActualWeight2,
    this.normalActualWeight2,
    this.specialDimensionalWeight2,
    this.normalDimensionalWeight2,
    this.length2,
    this.width2,
    this.height2,
    this.calculatedDimensionalWeight2,
    this.calculatedFinalWeight2,
    this.customerId2,
    this.firstName2,
    this.lastName2,
  }) : super(
         id: id2!,
         shipmentId: shipmentId2!,
         actualWeight: actualWeight2 ?? "0.0",
         specialActualWeight: specialActualWeight2 ?? "0.0",
         normalActualWeight: normalActualWeight2 ?? "0.0",
         specialDimensionalWeight: specialDimensionalWeight2 ?? "0.0",
         normalDimensionalWeight: normalDimensionalWeight2,
         length: length2 ?? "",
         width: width2 ?? '',
         height: height2 ?? "",
         calculatedDimensionalWeight: calculatedDimensionalWeight2 ?? "",
         calculatedFinalWeight: calculatedFinalWeight2 ?? '',
         customerId: customerId2!,
         firstName: firstName2 ?? "",
         lastName: lastName2 ?? "",
       );

  factory GetAllParcelsModel.fromJson(Map<String, dynamic> json) {
    return GetAllParcelsModel(
      id2: json['id'] as int?,
      shipmentId2: json['shipment_id'] as int?,
      actualWeight2: json['actual_weight'] as String?,
      specialActualWeight2: json['special_actual_weight'] as String?,
      normalActualWeight2: json['normal_actual_weight'] as dynamic,
      specialDimensionalWeight2: json['special_dimensional_weight'] as dynamic,
      normalDimensionalWeight2: json['normal_dimensional_weight'] as dynamic,
      length2: json['length'] as String?,
      width2: json['width'] as String?,
      height2: json['height'] as String?,
      calculatedDimensionalWeight2:
          json['calculated_dimensional_weight'] as String?,
      calculatedFinalWeight2: json['calculated_final_weight'] as String?,
      customerId2: json['customer_id'] as int?,
      firstName2: json['first_name'] as String?,
      lastName2: json['last_name'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'shipment_id': shipmentId,
    'actual_weight': actualWeight,
    'special_actual_weight': specialActualWeight,
    'normal_actual_weight': normalActualWeight,
    'special_dimensional_weight': specialDimensionalWeight,
    'normal_dimensional_weight': normalDimensionalWeight,
    'length': length,
    'width': width,
    'height': height,
    'calculated_dimensional_weight': calculatedDimensionalWeight,
    'calculated_final_weight': calculatedFinalWeight,
    'customer_id': customerId,
    'first_name': firstName,
    'last_name': lastName,
  };
}
