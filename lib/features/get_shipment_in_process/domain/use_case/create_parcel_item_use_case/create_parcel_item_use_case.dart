import 'package:dartz/dartz.dart';
import 'package:final_subul_project/core/errors/failure.dart';
import 'package:final_subul_project/core/use_cases/use_case.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/entities/create_parcel_item_entity/create_parcel_item_entity.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/repos/create_parcel_item_repo/create_parcel_item_repo.dart';

class CreateParcelItemUseCase
    extends UseCase<CreateParcelItemEntity, CreateParcelItemParams> {
  final CreateParcelItemRepo createParcelItemRepo;

  CreateParcelItemUseCase(this.createParcelItemRepo);
  @override
  Future<Either<Failure, CreateParcelItemEntity>> call([
    CreateParcelItemParams? params,
  ]) async {
    return await createParcelItemRepo.createParcelItem(
      type: params!.type,
      quantity: params.quantity,
      valuePerItem: params.valuePerItem,
      description: params.description,
      id: params.id,
    );
  }
}

class CreateParcelItemParams {
  final String type;
  final int quantity;
  final int valuePerItem;
  final String description;
  final int id;

  CreateParcelItemParams({
    required this.id,
    required this.type,
    required this.quantity,
    required this.valuePerItem,
    required this.description,
  });
}
