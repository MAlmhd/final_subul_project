import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:final_subul_project/features/get_shipments_in_the_way/domain/entity/update_shipments_warehouse_arrival_entity/update_shipments_warehouse_arrival_entity.dart';
import 'package:final_subul_project/features/get_shipments_in_the_way/domain/use_case/update_shipments_warehouse_arrival_use_case/update_shipments_warehouse_arrival_use_case.dart';

part 'update_shipments_warehouse_arrival_state.dart';

class UpdateShipmentsWarehouseArrivalCubit
    extends Cubit<UpdateShipmentsWarehouseArrivalState> {
  final UpdateShipmentsWarehouseArrivalUseCase
  updateShipmentsWarehouseArrivalUseCase;
  UpdateShipmentsWarehouseArrivalCubit(
    this.updateShipmentsWarehouseArrivalUseCase,
  ) : super(UpdateShipmentsWarehouseArrivalInitial());

  Future<void> updateShipment({required int id, required XFile image}) async {
    emit(UpdateShipmentsWarehouseArrivalLoading());
    UpdateShipmentsWarehouseArrivalParams
    updateShipmentsWarehouseArrivalParams =
        UpdateShipmentsWarehouseArrivalParams(id: id, image: image);
    var data = await updateShipmentsWarehouseArrivalUseCase.call(
      updateShipmentsWarehouseArrivalParams,
    );
    data.fold(
      (failure) {
        emit(UpdateShipmentsWarehouseArrivalFailure(failure.message));
      },
      (success) {
        emit(UpdateShipmentsWarehouseArrivalSuccess(success));
      },
    );
  }
}
