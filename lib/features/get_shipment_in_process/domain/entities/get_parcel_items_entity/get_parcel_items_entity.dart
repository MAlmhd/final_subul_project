class GetParcelItemsEntity {
  final int id;
  final int parcelId;
  final String itemType;
  final int quantity;
  final String valuePerItem;
  final String description;

  GetParcelItemsEntity({required this.id, required this.parcelId, required this.itemType, required this.quantity, required this.valuePerItem, required this.description});

}
