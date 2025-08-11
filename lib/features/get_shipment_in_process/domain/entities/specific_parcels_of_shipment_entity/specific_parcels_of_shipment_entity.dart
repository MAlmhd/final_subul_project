
class SpecificParcelsOfShipmentEntity{
  final int id;
  final int shipmentId;
  final String actualWeight;
  final String specialActualWeight;
  final String normalActualWeight;
  final String? specialDimensionalWeight;
  final String? normalDimensionalWeight;
  final String length;
  final String width;
  final String height;
  final String calculatedDimensionalWeight;
  final String calculatedFinalWeight;
  final int customerId;
  final String firstName;
  final String lastName;

  const SpecificParcelsOfShipmentEntity({
    required this.id,
    required this.shipmentId,
    required this.actualWeight,
    required this.specialActualWeight,
    required this.normalActualWeight,
    required this.specialDimensionalWeight,
    required this.normalDimensionalWeight,
    required this.length,
    required this.width,
    required this.height,
    required this.calculatedDimensionalWeight,
    required this.calculatedFinalWeight,
    required this.customerId,
    required this.firstName,
    required this.lastName,
  });

}
