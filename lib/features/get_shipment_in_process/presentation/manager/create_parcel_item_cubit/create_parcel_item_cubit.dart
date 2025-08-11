import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/entities/create_parcel_item_entity/create_parcel_item_entity.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/use_case/create_parcel_item_use_case/create_parcel_item_use_case.dart';

part 'create_parcel_item_state.dart';

class CreateParcelItemCubit extends Cubit<CreateParcelItemState> {
  final CreateParcelItemUseCase createParcelItemUseCase;
  CreateParcelItemCubit(this.createParcelItemUseCase)
    : super(CreateParcelItemInitial());

  Future<void> createParcelItem({
    required String type,
    required int quantity,
    required int valuePerItem,
    required String description,
    required int id,
  }) async {
    emit(CreateParcelItemLoading());
    CreateParcelItemParams createParcelItemParams = CreateParcelItemParams(
      id: id,
      type: type,
      quantity: quantity,
      valuePerItem: valuePerItem,
      description: description,
    );
    var data = await createParcelItemUseCase.call(createParcelItemParams);
    data.fold(
      (failure) {
        emit(CreateParcelItemFailure(failure.message));
      },
      (success) {
        emit(CreateParcelItemSuccess(success));
      },
    );
  }
}
