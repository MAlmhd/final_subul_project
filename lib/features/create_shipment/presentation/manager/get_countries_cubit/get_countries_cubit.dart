import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:final_subul_project/features/create_shipment/domain/entities/country_entity/country_entity.dart';
import 'package:final_subul_project/features/create_shipment/domain/use_case/get_countries_use_case/get_countries_use_case.dart';

part 'get_countries_state.dart';

class GetCountriesCubit extends Cubit<GetCountriesState> {
  GetCountriesCubit(this.getCountriesUseCase) : super(GetCountriesInitial());
  final GetCountriesUseCase getCountriesUseCase;

  Future<void> getCountries() async {
    emit(GetCountriesLoading());
    var data = await getCountriesUseCase.call();
    data.fold(
      (failure) {
        emit(GetCountriesFailure(failure.message));
      },
      (success) {
        emit(GetCountriesSuccess(success));
      },
    );
  }
}
