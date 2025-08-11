import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:final_subul_project/core/data/auth_local_data_source.dart';
import 'package:final_subul_project/core/utils/api_service.dart';
import 'package:final_subul_project/features/create_shipment/data/data_source/create_shipment_data_source/create_shipment_remote_data_source.dart';
import 'package:final_subul_project/features/create_shipment/data/data_source/get_countries_data_source/get_countries_remote_data_source.dart';
import 'package:final_subul_project/features/create_shipment/data/data_source/get_users_data_source/get_users_remote_data_source.dart';
import 'package:final_subul_project/features/create_shipment/data/repos/create_shipment_repo_impl/create_shipment_repo_impl.dart';
import 'package:final_subul_project/features/create_shipment/data/repos/get_countries_repo_impl/get_countries_repo_impl.dart';
import 'package:final_subul_project/features/create_shipment/data/repos/get_user_repo_impl/get_users_repo_impl.dart';
import 'package:final_subul_project/features/create_shipment/domain/repos/create_shipment_repo/create_shipment_repo.dart';
import 'package:final_subul_project/features/create_shipment/domain/repos/get_countries_repo/get_countries_repo.dart';
import 'package:final_subul_project/features/create_shipment/domain/repos/get_users_repo/get_users_repo.dart';
import 'package:final_subul_project/features/create_shipment/domain/use_case/create_shipment_use_case/create_shipment_use_case.dart';
import 'package:final_subul_project/features/create_shipment/domain/use_case/get_countries_use_case/get_countries_use_case.dart';
import 'package:final_subul_project/features/create_shipment/domain/use_case/get_users_use_case/get_user_use_case.dart';
import 'package:final_subul_project/features/get_all_parcels/data/data_source/get_all_parcels_data_source/get_all_parcels_remote_data_source.dart';
import 'package:final_subul_project/features/get_all_parcels/data/repos/get_all_parcels_repo_impl/get_all_parcels_repo_impl.dart';
import 'package:final_subul_project/features/get_all_parcels/domain/repos/get_all_parcels_repo/get_all_parcels_repo.dart';
import 'package:final_subul_project/features/get_all_parcels/domain/use_case/get_all_parcels_use_case/get_all_parcels_use_case.dart';
import 'package:final_subul_project/features/get_customer_shipment/data/data_source/get_customer_shipments_remote_data_source.dart';
import 'package:final_subul_project/features/get_customer_shipment/data/repos/get_customer_shipments_repo_impl.dart';
import 'package:final_subul_project/features/get_customer_shipment/domain/repos/get_customer_shipments.dart';
import 'package:final_subul_project/features/get_customer_shipment/domain/use_case/get_customer_shipments_use_case.dart';
import 'package:final_subul_project/features/get_rejected_shipments/data/data_source/get_rejected_shipments_remote_data_source.dart';
import 'package:final_subul_project/features/get_rejected_shipments/data/repos/get_rejected_shipments_repo_impl.dart';
import 'package:final_subul_project/features/get_rejected_shipments/domain/repos/get_rejected_shipments_repo.dart';
import 'package:final_subul_project/features/get_rejected_shipments/domain/use_case/get_rejected_shipments_use_case.dart';
import 'package:final_subul_project/features/get_shipment_in_process/data/data_source/create_parcel_data_source/create_parcel_remote_data_source.dart';
import 'package:final_subul_project/features/get_shipment_in_process/data/data_source/create_parcel_item_data_source/create_parcel_item_remote_data_source.dart';
import 'package:final_subul_project/features/get_shipment_in_process/data/data_source/get_allowed_content_data_source/get_allowed_content_remote_data_source.dart';
import 'package:final_subul_project/features/get_shipment_in_process/data/data_source/get_drivers_data_source/get_drivers_remote_data_source.dart';
import 'package:final_subul_project/features/get_shipment_in_process/data/data_source/get_parcel_items_data_source/get_parcel_items_remote_data_source.dart';
import 'package:final_subul_project/features/get_shipment_in_process/data/data_source/get_shipment_details_data_source/get_shipment_details_remote_data_source.dart';
import 'package:final_subul_project/features/get_shipment_in_process/data/data_source/get_shipment_parcels_data_source/get_shipment_parcels_remote_data_source.dart';
import 'package:final_subul_project/features/get_shipment_in_process/data/data_source/get_shipments_in_process_data_source/get_shipment_in_process_remote_data_source.dart';
import 'package:final_subul_project/features/get_shipment_in_process/data/data_source/update_shipment_destenation_data_source/update_shipment_destenation_remote_date_source.dart';
import 'package:final_subul_project/features/get_shipment_in_process/data/data_source/update_shipment_for_delivery_data_source/update_shipment_for_delivery_remote_data_source.dart';
import 'package:final_subul_project/features/get_shipment_in_process/data/data_source/update_shipment_origin_country_data_source/update_shipment_origin_country_remote_data_source.dart';
import 'package:final_subul_project/features/get_shipment_in_process/data/repos/create_parcel_item_repo_impl/create_parcel_item_repo_impl.dart';
import 'package:final_subul_project/features/get_shipment_in_process/data/repos/create_parcel_repo_impl/create_parcel_repo_impl.dart';
import 'package:final_subul_project/features/get_shipment_in_process/data/repos/get_allowed_content_repo_impl/get_allowed_content_repo_impl.dart';
import 'package:final_subul_project/features/get_shipment_in_process/data/repos/get_drivers_repo_impl/get_drivers_repo_impl.dart';
import 'package:final_subul_project/features/get_shipment_in_process/data/repos/get_parcel_items_repo_impl/get_parcel_items_repo_impl.dart';
import 'package:final_subul_project/features/get_shipment_in_process/data/repos/get_shipment_details_repo_impl/get_shipment_details_repo_impl.dart';
import 'package:final_subul_project/features/get_shipment_in_process/data/repos/get_shipment_parcels_repo_impl/get_shipment_parcels_repo_impl.dart';
import 'package:final_subul_project/features/get_shipment_in_process/data/repos/get_shipments_in_process_repo_impl/get_shipments_in_process_repo_impl.dart';
import 'package:final_subul_project/features/get_shipment_in_process/data/repos/update_shipment_destenation_repo_impl/update_shipment_destenation_repo_impl.dart';
import 'package:final_subul_project/features/get_shipment_in_process/data/repos/update_shipment_for_delivery_repo_impl/update_shipment_for_delivery_repo_impl.dart';
import 'package:final_subul_project/features/get_shipment_in_process/data/repos/update_shipment_origin_country_repo_impl/update_shipment_origin_country_repo_impl.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/repos/create_parcel_item_repo/create_parcel_item_repo.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/repos/create_parcel_repo/create_parcel_repo.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/repos/get_allowed_content_repo/get_allowed_content_repo.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/repos/get_drivers_repo/get_drivers_repo.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/repos/get_parcel_items_repo/get_parcel_items_repo.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/repos/get_shipment_details_repo/get_shipment_details_repo.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/repos/get_shipment_parcels_repo/get_shipment_parcels_repo.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/repos/get_shipments_in_process_repo/get_shipments_in_process_repo.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/repos/update_shipment_destenation_country_repo/update_shipment_destenation_country_repo.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/repos/update_shipment_for_delivery_repo/update_shipment_for_delivery_repo.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/repos/update_shipment_origin_country_repo/update_shipment_origin_country_repo.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/use_case/create_parcel_item_use_case/create_parcel_item_use_case.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/use_case/create_parcel_use_case/create_parcel_use_case.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/use_case/get_allowed_content_use_case/get_allowed_content_use_case.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/use_case/get_drivers_use_case/get_drivers_use_case.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/use_case/get_parcel_items_use_case/get_parcel_items_use_case.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/use_case/get_shipment_details_use_case/get_shipment_details_use_case.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/use_case/get_shipment_parcels_use_case/get_shipment_parcels_use_case.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/use_case/get_shipments_in_process_use_case/get_shipments_in_process_use_case.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/use_case/update_shipment_destenation_country_use_case/update_shipment_destenation_country_use_case.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/use_case/update_shipment_for_delivery_use_case/update_shipment_for_delivery_use_case.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/use_case/update_shipment_origin_country_use_case/update_shipment_origin_use_case.dart';
import 'package:final_subul_project/features/get_shipments_in_the_way/data/data_source/get_shipments_in_the_way_data_source/get_shipments_in_the_way_remote_data_source.dart';
import 'package:final_subul_project/features/get_shipments_in_the_way/data/data_source/update_shipments_warehouse_arrival_data_source/update_shipments_warehouse_arrival_remote_data_source.dart';
import 'package:final_subul_project/features/get_shipments_in_the_way/data/repos/get_shipments_in_the_way_repo_impl/get_shipments_in_the_way_repo_impl.dart';
import 'package:final_subul_project/features/get_shipments_in_the_way/data/repos/update_shipments_warehouse_arrival_repo_impl/update_shipments_warehouse_arrival_repo_impl.dart';
import 'package:final_subul_project/features/get_shipments_in_the_way/domain/repos/get_shipments_in_the_way_repo/get_shipments_in_the_way_repo.dart';
import 'package:final_subul_project/features/get_shipments_in_the_way/domain/repos/update_shipments_warehouse_arrival_repo/update_shipments_warehouse_arrival_repo.dart';
import 'package:final_subul_project/features/get_shipments_in_the_way/domain/use_case/get_shipments_in_the_way_use_case/get_shipments_in_the_way_use_case.dart';
import 'package:final_subul_project/features/get_shipments_in_the_way/domain/use_case/update_shipments_warehouse_arrival_use_case/update_shipments_warehouse_arrival_use_case.dart';
import 'package:final_subul_project/features/get_unapproved_shipments/data/data_source/approve_shipment_data_source/approve_shipment_remote_data_source.dart';
import 'package:final_subul_project/features/get_unapproved_shipments/data/data_source/get_unapproved_shipments_data_source/get_unapproved_shipments_remote_data_source.dart';
import 'package:final_subul_project/features/get_unapproved_shipments/data/data_source/reject_shipment_data_soure/reject_shipment_remote_data_source.dart';
import 'package:final_subul_project/features/get_unapproved_shipments/data/repos/approve_shipment_repo_impl/approve_shipment_repo_impl.dart';
import 'package:final_subul_project/features/get_unapproved_shipments/data/repos/get_unapproved_shipments_repo_impl/get_unapproved_shipments_repo_impl.dart';
import 'package:final_subul_project/features/get_unapproved_shipments/data/repos/reject_shipment_repo_impl/reject_shipment_repo_impl.dart';
import 'package:final_subul_project/features/get_unapproved_shipments/domain/repos/approve_shipment_repo/approve_shipment_repo.dart';
import 'package:final_subul_project/features/get_unapproved_shipments/domain/repos/get_unapproved_shipment_repo/get_unapproved_shipments_repo.dart';
import 'package:final_subul_project/features/get_unapproved_shipments/domain/repos/reject_shipment_repo/reject_shipment_repo.dart';
import 'package:final_subul_project/features/get_unapproved_shipments/domain/use_case/approve_shipment_use_case/approve_shipment_use_case.dart';
import 'package:final_subul_project/features/get_unapproved_shipments/domain/use_case/get_unapproved_shipments_use_case/get_unapproved_shipments_use_case.dart';
import 'package:final_subul_project/features/get_unapproved_shipments/domain/use_case/reject_shipment_use_case/reject_shipment_use_case.dart';
import 'package:final_subul_project/features/register_client/data/data_source/get_companies_data_source/get_companies_remote_data_source.dart';
import 'package:final_subul_project/features/register_client/data/data_source/register_client_data_source/register_client_remote_data_source.dart';
import 'package:final_subul_project/features/register_client/data/repos/get_companies_repo/get_companies_repo_impl.dart';
import 'package:final_subul_project/features/register_client/data/repos/register_client_repo/register_client_repo_impl.dart';
import 'package:final_subul_project/features/register_client/domain/repos/get_companies_repo.dart';
import 'package:final_subul_project/features/register_client/domain/repos/register_client_repo.dart';
import 'package:final_subul_project/features/register_client/domain/use_cases/get_companies_use_case.dart';
import 'package:final_subul_project/features/register_client/domain/use_cases/register_client_use_case.dart';
import 'package:final_subul_project/features/register_company/data/data_source/register_company_remote_data_source.dart';
import 'package:final_subul_project/features/register_company/data/repos/register_company_repo_impl.dart';
import 'package:final_subul_project/features/register_company/domain/repo/register_company_repo.dart';
import 'package:final_subul_project/features/register_company/domain/use_case/register_company_use_case.dart';
import 'package:final_subul_project/features/show_companies_and_clients/data/data_source/delete_user_data_source/delete_user_remote_data_source.dart';
import 'package:final_subul_project/features/show_companies_and_clients/data/data_source/show_companies_and_clients_data_source/show_companies_and_clients_remote_data_source.dart';
import 'package:final_subul_project/features/show_companies_and_clients/data/repos/delete_user_repo/delete_user_repo_impl.dart';
import 'package:final_subul_project/features/show_companies_and_clients/data/repos/show_companies_and_clients_repo/show_companies_and_clients_repo_impl.dart';
import 'package:final_subul_project/features/show_companies_and_clients/domain/repos/delete_user_repo/delete_user_repo.dart';
import 'package:final_subul_project/features/show_companies_and_clients/domain/repos/show_companies_and_clients_repo/show_companies_and_clients_repo.dart';
import 'package:final_subul_project/features/show_companies_and_clients/domain/use_case/delete_user_use_case/delete_user_use_case.dart';
import 'package:final_subul_project/features/show_companies_and_clients/domain/use_case/show_companies_and_clients_use_case/show_companies_and_clients_use_case.dart';
import 'package:final_subul_project/features/sign_in/data/data_sources/sign_in_remote_data_source.dart';
import 'package:final_subul_project/features/sign_in/data/repos/sign_in_repo_impl.dart';
import 'package:final_subul_project/features/sign_in/domain/repos/sign_in_repo.dart';
import 'package:final_subul_project/features/sign_in/domain/use_cases/sign_in_use_case.dart';
import 'package:final_subul_project/features/track_shipments_home/data/data_source/create_invoice_data_source/create_invoice_remote_data_source.dart';
import 'package:final_subul_project/features/track_shipments_home/data/data_source/get_approved_shipments_data_source/get_approved_shipments_remote_data_source.dart';
import 'package:final_subul_project/features/track_shipments_home/data/data_source/get_invoices_data_source/get_invoices_remote_data_source.dart';
import 'package:final_subul_project/features/track_shipments_home/data/repo/create_invoice_repo/create_invoice_repo_impl.dart';
import 'package:final_subul_project/features/track_shipments_home/data/repo/get_approved_shipments_repo/get_approved_shipments_repo_impl.dart';
import 'package:final_subul_project/features/track_shipments_home/data/repo/get_invoices_repo_impl/get_invoices_repo_impl.dart';
import 'package:final_subul_project/features/track_shipments_home/domain/repos/create_invoice_repo/create_invoice_repo.dart';
import 'package:final_subul_project/features/track_shipments_home/domain/repos/get_approved_shipments_repo/get_approved_shipments_repo.dart';
import 'package:final_subul_project/features/track_shipments_home/domain/repos/get_invoices_repo/get_invoices_repo.dart';
import 'package:final_subul_project/features/track_shipments_home/domain/use_case/create_invoice_use_case/create_invoice_use_case.dart';
import 'package:final_subul_project/features/track_shipments_home/domain/use_case/get_approved_shipments_use_case/get_approved_shipments_use_case.dart';
import 'package:final_subul_project/features/track_shipments_home/domain/use_case/get_invoices_use_case/get_invoice_use_case.dart';

final GetIt sl = GetIt.instance;

void setupServiceLocator() {
  // Core
  sl.registerLazySingleton<Dio>(() => Dio());
  sl.registerLazySingleton<FlutterSecureStorage>(() => FlutterSecureStorage());
  sl.registerLazySingleton<ApiService>(() => ApiService(sl<Dio>()));
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(storage: sl<FlutterSecureStorage>()),
  );

  // sign in

  sl.registerLazySingleton<SignInRemoteDataSource>(
    () => SignInRemoteDataSourceImpl(sl<ApiService>()),
  );
  sl.registerLazySingleton<SignInRepo>(
    () => SignInRepoImpl(
      signInRemoteDataSource: sl<SignInRemoteDataSource>(),
      authLocalDataSource: sl<AuthLocalDataSource>(),
    ),
  );
  sl.registerLazySingleton<SignInUseCase>(
    () => SignInUseCase(sl<SignInRepo>()),
  );

  // get users
  sl.registerLazySingleton<GetUsersRemoteDataSource>(
    () => GetUsersRemoteDataSourceImpl(sl.get<ApiService>()),
  );
  sl.registerLazySingleton<GetUsersRepo>(
    () => GetUsersRepoImpl(sl.get<GetUsersRemoteDataSource>()),
  );
  sl.registerLazySingleton<GetUserUseCase>(
    () => GetUserUseCase(sl<GetUsersRepo>()),
  );

  // get countries
  sl.registerLazySingleton<GetCountriesRemoteDataSource>(
    () => GetCountriesRemoteDataSourceImpl(sl.get<ApiService>()),
  );
  sl.registerLazySingleton<GetCountriesRepo>(
    () => GetCountriesRepoImpl(sl.get<GetCountriesRemoteDataSource>()),
  );
  sl.registerLazySingleton<GetCountriesUseCase>(
    () => GetCountriesUseCase(sl<GetCountriesRepo>()),
  );
  // create shipment
  sl.registerLazySingleton<CreateShipmentRemoteDataSource>(
    () => CreateShipmentRemoteDataSourceImpl(sl.get<ApiService>()),
  );
  sl.registerLazySingleton<CreateShipmentRepo>(
    () => CreateShipmentRepoImpl(sl.get<CreateShipmentRemoteDataSource>()),
  );
  sl.registerLazySingleton<CreateShipmentUseCase>(
    () => CreateShipmentUseCase(sl.get<CreateShipmentRepo>()),
  );

  // get shipments in proccess
  sl.registerLazySingleton<GetShipmentInProcessRemoteDataSource>(
    () => GetShipmentInProcessRemoteDataSourceImpl(sl.get<ApiService>()),
  );
  sl.registerLazySingleton<GetShipmentsInProcessRepo>(
    () => GetShipmentsInProcessRepoImpl(
      sl.get<GetShipmentInProcessRemoteDataSource>(),
    ),
  );
  sl.registerLazySingleton<GetShipmentsInProcessUseCase>(
    () => GetShipmentsInProcessUseCase(
      getShipmentsInProcessRepo: sl.get<GetShipmentsInProcessRepo>(),
    ),
  );
  // update shipment origin country
  sl.registerLazySingleton<UpdateShipmentOriginCountryRemoteDataSource>(
    () => UpdateShipmentOriginCountryRemoteDataSourceImpl(sl.get<ApiService>()),
  );
  sl.registerLazySingleton<UpdateShipmentOriginCountryRepo>(
    () => UpdateShipmentOriginCountryRepoImpl(
      sl.get<UpdateShipmentOriginCountryRemoteDataSource>(),
    ),
  );
  sl.registerLazySingleton<UpdateShipmentOriginUseCase>(
    () =>
        UpdateShipmentOriginUseCase(sl.get<UpdateShipmentOriginCountryRepo>()),
  );

  // update shipment destenation country
  sl.registerLazySingleton<UpdateShipmentDestenationRemoteDateSource>(
    () => UpdateShipmentDestenationRemoteDateSourceImpl(sl.get<ApiService>()),
  );
  sl.registerLazySingleton<UpdateShipmentDestenationCountryRepo>(
    () => UpdateShipmentDestenationRepoImpl(
      sl.get<UpdateShipmentDestenationRemoteDateSource>(),
    ),
  );
  sl.registerLazySingleton<UpdateShipmentDestenationCountryUseCase>(
    () => UpdateShipmentDestenationCountryUseCase(
      sl.get<UpdateShipmentDestenationCountryRepo>(),
    ),
  );

  // get drivers
  sl.registerLazySingleton<GetDriversRemoteDataSource>(
    () => GetDriversRemoteDataSourceImpl(sl.get<ApiService>()),
  );
  sl.registerLazySingleton<GetDriversRepo>(
    () => GetDriversRepoImpl(sl.get<GetDriversRemoteDataSource>()),
  );
  sl.registerLazySingleton<GetDriversUseCase>(
    () => GetDriversUseCase(sl.get<GetDriversRepo>()),
  );

  // update shipment for delivery
  sl.registerLazySingleton<UpdateShipmentForDeliveryRemoteDataSource>(
    () => UpdateShipmentForDeliveryRemoteDataSourceImpl(sl.get<ApiService>()),
  );
  sl.registerLazySingleton<UpdateShipmentForDeliveryRepo>(
    () => UpdateShipmentForDeliveryRepoImpl(
      sl.get<UpdateShipmentForDeliveryRemoteDataSource>(),
    ),
  );
  sl.registerLazySingleton<UpdateShipmentForDeliveryUseCase>(
    () => UpdateShipmentForDeliveryUseCase(
      sl.get<UpdateShipmentForDeliveryRepo>(),
    ),
  );

  // get shipment details
  sl.registerLazySingleton<GetShipmentDetailsRemoteDataSource>(
    () => GetShipmentDetailsRemoteDataSourceImpl(sl.get<ApiService>()),
  );
  sl.registerLazySingleton<GetShipmentDetailsRepo>(
    () => GetShipmentDetailsRepoImpl(
      sl.get<GetShipmentDetailsRemoteDataSource>(),
    ),
  );
  sl.registerLazySingleton<GetShipmentDetailsUseCase>(
    () => GetShipmentDetailsUseCase(sl.get<GetShipmentDetailsRepo>()),
  );

  // get all parcels
  sl.registerLazySingleton<GetAllParcelsRemoteDataSource>(
    () => GetAllParcelsRemoteDataSourceImpl(sl.get<ApiService>()),
  );
  sl.registerLazySingleton<GetAllParcelsRepo>(
    () => GetAllParcelsRepoImpl(sl.get<GetAllParcelsRemoteDataSource>()),
  );
  sl.registerLazySingleton<GetAllParcelsUseCase>(
    () => GetAllParcelsUseCase(sl.get<GetAllParcelsRepo>()),
  );

  // get shipment parcels
  sl.registerLazySingleton<GetShipmentParcelsRemoteDataSource>(
    () => GetShipmentParcelsRemoteDataSourceImpl(sl.get<ApiService>()),
  );
  sl.registerLazySingleton<GetShipmentParcelsRepo>(
    () => GetShipmentParcelsRepoImpl(
      sl.get<GetShipmentParcelsRemoteDataSource>(),
    ),
  );

  sl.registerLazySingleton<GetShipmentParcelsUseCase>(
    () => GetShipmentParcelsUseCase(sl.get<GetShipmentParcelsRepo>()),
  );

  // create parcel
  sl.registerLazySingleton<CreateParcelRemoteDataSource>(
    () => CreateParcelRemoteDataSourceImpl(sl.get<ApiService>()),
  );
  sl.registerLazySingleton<CreateParcelRepo>(
    () => CreateParcelRepoImpl(sl.get<CreateParcelRemoteDataSource>()),
  );

  sl.registerLazySingleton<CreateParcelUseCase>(
    () => CreateParcelUseCase(sl.get<CreateParcelRepo>()),
  );

  // create parcel item
  sl.registerLazySingleton<CreateParcelItemRemoteDataSource>(
    () => CreateParcelItemRemoteDataSourceImpl(sl.get<ApiService>()),
  );
  sl.registerLazySingleton<CreateParcelItemRepo>(
    () => CreateParcelItemRepoImpl(sl.get<CreateParcelItemRemoteDataSource>()),
  );

  sl.registerLazySingleton<CreateParcelItemUseCase>(
    () => CreateParcelItemUseCase(sl.get<CreateParcelItemRepo>()),
  );

  // get allowed content
  sl.registerLazySingleton<GetAllowedContentRemoteDataSource>(
    () => GetAllowedContentRemoteDataSourceImpl(sl.get<ApiService>()),
  );
  sl.registerLazySingleton<GetAllowedContentRepo>(
    () =>
        GetAllowedContentRepoImpl(sl.get<GetAllowedContentRemoteDataSource>()),
  );

  sl.registerLazySingleton<GetAllowedContentUseCase>(
    () => GetAllowedContentUseCase(sl.get<GetAllowedContentRepo>()),
  );

  // get parcel items
  sl.registerLazySingleton<GetParcelItemsRemoteDataSource>(
    () => GetParcelItemsRemoteDataSourceImpl(sl.get<ApiService>()),
  );
  sl.registerLazySingleton<GetParcelItemsRepo>(
    () => GetParcelItemsRepoImpl(sl.get<GetParcelItemsRemoteDataSource>()),
  );

  sl.registerLazySingleton<GetParcelItemsUseCase>(
    () => GetParcelItemsUseCase(sl.get<GetParcelItemsRepo>()),
  );

  // get shipmetns in the way
  sl.registerLazySingleton<GetShipmentsInTheWayRemoteDataSource>(
    () => GetShipmentsInTheWayRemoteDataSourceImpl(sl.get<ApiService>()),
  );
  sl.registerLazySingleton<GetShipmentsInTheWayRepo>(
    () => GetShipmentsInTheWayRepoImpl(
      sl.get<GetShipmentsInTheWayRemoteDataSource>(),
    ),
  );

  sl.registerLazySingleton<GetShipmentsInTheWayUseCase>(
    () => GetShipmentsInTheWayUseCase(sl.get<GetShipmentsInTheWayRepo>()),
  );

  // update shipments warehouse arrival
  sl.registerLazySingleton<UpdateShipmentsWarehouseArrivalRemoteDataSource>(
    () => UpdateShipmentsWarehouseArrivalRemoteDataSourceImpl(
      sl.get<ApiService>(),
    ),
  );
  sl.registerLazySingleton<UpdateShipmentsWarehouseArrivalRepo>(
    () => UpdateShipmentsWarehouseArrivalRepoImpl(
      sl.get<UpdateShipmentsWarehouseArrivalRemoteDataSource>(),
    ),
  );

  sl.registerLazySingleton<UpdateShipmentsWarehouseArrivalUseCase>(
    () => UpdateShipmentsWarehouseArrivalUseCase(
      sl.get<UpdateShipmentsWarehouseArrivalRepo>(),
    ),
  );

  // get companies

  sl.registerLazySingleton<GetCompaniesRemoteDataSource>(
    () => GetCompaniesRemoteDataSourceImpl(sl.get<ApiService>()),
  );

  // sl.registerLazySingleton<GetCompaniesLocalDataSource>(
  //   () => GetCompaniesLocalDataSourceImpl(),
  // );

  sl.registerLazySingleton<GetCompaniesRepo>(
    () => GetCompaniesRepoImpl(
      // getCompaniesLocalDataSource: sl.get<GetCompaniesLocalDataSource>(),
      getCompaniesRemoteDataSource: sl.get<GetCompaniesRemoteDataSource>(),
    ),
  );

  sl.registerLazySingleton<GetCompaniesUseCase>(
    () => GetCompaniesUseCase(sl.get<GetCompaniesRepo>()),
  );

  // register client
  sl.registerLazySingleton<RegisterClientRemoteDataSource>(
    () => RegisterClientRemoteDataSourceImpl(sl.get<ApiService>()),
  );

  sl.registerLazySingleton<RegisterClientRepo>(
    () => RegisterClientRepoImpl(sl.get<RegisterClientRemoteDataSource>()),
  );

  sl.registerLazySingleton<RegisterClientUseCase>(
    () => RegisterClientUseCase(sl.get<RegisterClientRepo>()),
  );
  // register company
  sl.registerLazySingleton<RegisterCompanyRemoteDataSource>(
    () => RegisterCompanyRemoteDataSourceImpl(sl.get<ApiService>()),
  );

  sl.registerLazySingleton<RegisterCompanyRepo>(
    () => RegisterCompanyRepoImpl(sl.get<RegisterCompanyRemoteDataSource>()),
  );

  sl.registerLazySingleton<RegisterCompanyUseCase>(
    () => RegisterCompanyUseCase(sl.get<RegisterCompanyRepo>()),
  );

  // show companies and clients

  sl.registerLazySingleton<ShowCompaniesAndClientsRemoteDataSource>(
    () => ShowCompaniesAndClientsRemoteDataSourceImpl(sl.get<ApiService>()),
  );

  // sl.registerLazySingleton<ShowCompaniesAndClientsLocalDataSource>(
  //   () => ShowCompaniesAndClientsLocalDataSourceImpl(),
  // );

  sl.registerLazySingleton<ShowCompaniesAndClientsRepo>(
    () => ShowCompaniesAndClientsRepoImpl(
      sl.get<ShowCompaniesAndClientsRemoteDataSource>(),
      //  sl.get<ShowCompaniesAndClientsLocalDataSource>()
    ),
  );

  sl.registerLazySingleton<ShowCompaniesAndClientsUseCase>(
    () => ShowCompaniesAndClientsUseCase(sl.get<ShowCompaniesAndClientsRepo>()),
  );

  // delete user

  sl.registerLazySingleton<DeleteUserRemoteDataSource>(
    () => DeleteUserRemoteDataSourceImpl(sl.get<ApiService>()),
  );

  // sl.registerLazySingleton<DeleteUserLocalDataSource>(
  //   () => DeleteUserLocalDataSourceImpl(),
  // );

  sl.registerLazySingleton<DeleteUserRepo>(
    () => DeleteUserRepoImpl(
      sl.get<DeleteUserRemoteDataSource>(),
      //sl.get<DeleteUserLocalDataSource>()
    ),
  );

  sl.registerLazySingleton<DeleteUserUseCase>(
    () => DeleteUserUseCase(sl.get<DeleteUserRepo>()),
  );

  // get approved shipments

  sl.registerLazySingleton<GetApprovedShipmentsRemoteDataSource>(
    () => GetApprovedShipmentsRemoteDataSourceImpl(sl.get<ApiService>()),
  );

  // sl.registerLazySingleton<GetApprovedShipmentsLocalDataSource>(
  //   () => GetApprovedShipmentsLocalDataSourceImpl(),
  // );

  sl.registerLazySingleton<GetApprovedShipmentsRepo>(
    () => GetApprovedShipmentsRepoImpl(
      sl.get<GetApprovedShipmentsRemoteDataSource>(),
      //  sl.get<GetApprovedShipmentsLocalDataSource>()
    ),
  );

  sl.registerLazySingleton<GetApprovedShipmentsUseCase>(
    () => GetApprovedShipmentsUseCase(sl.get<GetApprovedShipmentsRepo>()),
  );

  // get unapproved shipments
  sl.registerLazySingleton<GetUnapprovedShipmentsRemoteDataSource>(
    () => GetUnapprovedShipmentsRemoteDataSourceImpl(sl.get<ApiService>()),
  );

  // sl.registerLazySingleton<GetUnapprovedShipmentsLocalDataSource>(
  //   () => GetUnapprovedShipmentsLocalDataSourceImpl(),
  // );

  sl.registerLazySingleton<GetUnapprovedShipmentsRepo>(
    () => GetUnapprovedShipmentsRepoImpl(
      sl.get<GetUnapprovedShipmentsRemoteDataSource>(),
      //  sl.get<GetUnapprovedShipmentsLocalDataSource>()
    ),
  );

  sl.registerLazySingleton<GetUnapprovedShipmentsUseCase>(
    () => GetUnapprovedShipmentsUseCase(sl.get<GetUnapprovedShipmentsRepo>()),
  );

  // create invoice

  sl.registerLazySingleton<CreateInvoiceRemoteDataSource>(
    () => CreateInvoiceRemoteDataSourceImpl(sl.get<ApiService>()),
  );

  sl.registerLazySingleton<CreateInvoiceRepo>(
    () => CreateInvoiceRepoImpl(sl.get<CreateInvoiceRemoteDataSource>()),
  );

  sl.registerLazySingleton<CreateInvoiceUseCase>(
    () => CreateInvoiceUseCase(sl.get<CreateInvoiceRepo>()),
  );

  // get rejected shipments
  sl.registerLazySingleton<GetRejectedShipmentsRemoteDataSource>(
    () => GetRejectedShipmentsRemoteDataSourceImpl(sl.get<ApiService>()),
  );

  // sl.registerLazySingleton<GetRejectedShipmentsLocalDataSource>(
  //   () => GetRejectedShipmentsLocalDataSourceImpl(),
  // );

  sl.registerLazySingleton<GetRejectedShipmentsRepo>(
    () => GetRejectedShipmentsRepoImpl(
      sl.get<GetRejectedShipmentsRemoteDataSource>(),
      // sl.get<GetRejectedShipmentsLocalDataSource>()
    ),
  );

  sl.registerLazySingleton<GetRejectedShipmentsUseCase>(
    () => GetRejectedShipmentsUseCase(sl.get<GetRejectedShipmentsRepo>()),
  );

  // approve shipment
  sl.registerLazySingleton<ApproveShipmentRemoteDataSource>(
    () => ApproveShipmentRemoteDataSourceImpl(sl.get<ApiService>()),
  );

  sl.registerLazySingleton<ApproveShipmentRepo>(
    () => ApproveShipmentRepoImpl(sl.get<ApproveShipmentRemoteDataSource>()),
  );

  sl.registerLazySingleton<ApproveShipmentUseCase>(
    () => ApproveShipmentUseCase(sl.get<ApproveShipmentRepo>()),
  );

  // reject shipment
  sl.registerLazySingleton<RejectShipmentRemoteDataSource>(
    () => RejectShipmentRemoteDataSourceImpl(sl.get<ApiService>()),
  );

  sl.registerLazySingleton<RejectShipmentRepo>(
    () => RejectShipmentRepoImpl(sl.get<RejectShipmentRemoteDataSource>()),
  );

  sl.registerLazySingleton<RejectShipmentUseCase>(
    () => RejectShipmentUseCase(sl.get<RejectShipmentRepo>()),
  );

  // get shipments by code
  sl.registerLazySingleton<GetCustomerShipmentsRemoteDataSource>(
    () => GetCustomerShipmentsRemoteDataSourceImpl(sl.get<ApiService>()),
  );

  sl.registerLazySingleton<GetCustomerShipmentsRepo>(
    () => GetCustomerShipmentsRepoImpl(
      sl.get<GetCustomerShipmentsRemoteDataSource>(),
    ),
  );

  sl.registerLazySingleton<GetCustomerShipmentsUseCase>(
    () => GetCustomerShipmentsUseCase(sl.get<GetCustomerShipmentsRepo>()),
  );

  // get invoice
  sl.registerLazySingleton<GetInvoicesRemoteDataSource>(
    () => GetInvoicesRemoteDataSourceImpl(sl.get<ApiService>()),
  );

  sl.registerLazySingleton<GetInvoicesRepo>(
    () => GetInvoicesRepoImpl(sl.get<GetInvoicesRemoteDataSource>()),
  );

  sl.registerLazySingleton<GetInvoiceUseCase>(
    () => GetInvoiceUseCase(getInvoicesRepo: sl.get<GetInvoicesRepo>()),
  );
}
