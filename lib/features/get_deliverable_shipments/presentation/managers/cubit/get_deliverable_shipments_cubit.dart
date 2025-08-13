import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'get_deliverable_shipments_state.dart';

class GetDeliverableShipmentsCubit extends Cubit<GetDeliverableShipmentsState> {
  GetDeliverableShipmentsCubit() : super(GetDeliverableShipmentsInitial());
}
