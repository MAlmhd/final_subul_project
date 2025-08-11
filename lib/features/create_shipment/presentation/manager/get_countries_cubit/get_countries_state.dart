part of 'get_countries_cubit.dart';

sealed class GetCountriesState extends Equatable {
  const GetCountriesState();

  @override
  List<Object> get props => [];
}

final class GetCountriesInitial extends GetCountriesState {}

final class GetCountriesFailure extends GetCountriesState {
  final String message;

  const GetCountriesFailure(this.message);
}

final class GetCountriesLoading extends GetCountriesState {}

final class GetCountriesSuccess extends GetCountriesState {
  final List<CountryEntity> countries;

  const GetCountriesSuccess(this.countries);
}
