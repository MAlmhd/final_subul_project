import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:final_subul_project/core/routing/routes.dart';
import 'package:final_subul_project/core/utils/service_locator.dart';
import 'package:final_subul_project/features/create_shipment/domain/use_case/get_countries_use_case/get_countries_use_case.dart';
import 'package:final_subul_project/features/create_shipment/presentation/manager/get_countries_cubit/get_countries_cubit.dart';
import 'package:final_subul_project/features/get_all_parcels/presentation/views/show_all_parcels.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/use_case/create_parcel_item_use_case/create_parcel_item_use_case.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/use_case/get_allowed_content_use_case/get_allowed_content_use_case.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/use_case/get_parcel_items_use_case/get_parcel_items_use_case.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/use_case/get_shipment_details_use_case/get_shipment_details_use_case.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/use_case/update_shipment_destenation_country_use_case/update_shipment_destenation_country_use_case.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/use_case/update_shipment_origin_country_use_case/update_shipment_origin_use_case.dart';
import 'package:final_subul_project/features/get_shipment_in_process/presentation/manager/create_parcel_item_cubit/create_parcel_item_cubit.dart';
import 'package:final_subul_project/features/get_shipment_in_process/presentation/manager/get_allowed_content_cubit/get_allowed_content_cubit.dart';
import 'package:final_subul_project/features/get_shipment_in_process/presentation/manager/get_parcel_items_cubit/get_parcel_items_cubit.dart';
import 'package:final_subul_project/features/get_shipment_in_process/presentation/manager/get_shipment_details/get_shipment_details_cubit.dart';
import 'package:final_subul_project/features/get_shipment_in_process/presentation/manager/update_shipment_destenation_country_cubit/update_shipment_destenation_country_cubit.dart';
import 'package:final_subul_project/features/get_shipment_in_process/presentation/manager/update_shipment_origin_country_cubit/update_shipment_origin_country_cubit.dart';
import 'package:final_subul_project/features/get_shipment_in_process/presentation/views/widgets/country_switch_container.dart';
import 'package:final_subul_project/features/get_shipment_in_process/presentation/views/widgets/create_parcel.dart';
import 'package:final_subul_project/features/get_shipment_in_process/presentation/views/widgets/create_parcel_item_screen.dart';
import 'package:final_subul_project/features/get_shipment_in_process/presentation/views/widgets/shipment_receipt.dart';
import 'package:final_subul_project/features/get_shipment_in_process/presentation/views/widgets/show_parcel_items_screen.dart';
import 'package:final_subul_project/features/get_shipment_in_process/presentation/views/widgets/show_parcels_of_specific_shipment.dart';
import 'package:final_subul_project/features/get_shipments_in_the_way/domain/use_case/update_shipments_warehouse_arrival_use_case/update_shipments_warehouse_arrival_use_case.dart';
import 'package:final_subul_project/features/get_shipments_in_the_way/presentation/manager/update_shipments_warehouse_arrival_cubit/update_shipments_warehouse_arrival_cubit.dart';
import 'package:final_subul_project/features/get_shipments_in_the_way/presentation/views/widgets/show_specific_parcels_of_in_the_way_shipments.dart';
import 'package:final_subul_project/features/get_shipments_in_the_way/presentation/views/widgets/update_shipments_warehouse_arrival_screen.dart';
import 'package:final_subul_project/features/get_shipment_in_process/presentation/views/widgets/upload_number_image_and_name_of_driver_shipment.dart';
import 'package:final_subul_project/features/home_view/presentation/views/home_view.dart';
import 'package:final_subul_project/features/track_shipments_home/domain/entities/approved_shipment_entity/approved_shipment_entity.dart';
import 'package:final_subul_project/features/track_shipments_home/presentation/track_shipments_home.dart';
import 'package:final_subul_project/features/track_shipments_home/presentation/views/widgets/details_of_bill.dart';
import 'package:final_subul_project/features/track_shipments_home/presentation/views/widgets/pay_the_bill.dart';
import 'package:final_subul_project/features/warehouse_manager/ui/widgets/dimension_calculation.dart';
import 'package:final_subul_project/features/warehouse_manager/ui/widgets/volumetric_weight_calculation.dart';
import 'package:final_subul_project/features/warehouse_manager/ui/widgets/warehouse_manager.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    //this arguments to be passed in any screen like this ( arguments as ClassName )
    final arguments = settings.arguments;

    switch (settings.name) {
      case Routes.warehouseManager:
        return MaterialPageRoute(builder: (_) => WarehouseManager());
      case Routes.showAllParcels:
        return MaterialPageRoute(builder: (_) => ShowAllParcels());
      case Routes.showParcelsOfSpecificShipment:
        final shipmentId = arguments as int;
        return MaterialPageRoute(
          builder: (_) => ShowParcelsOfSpecificShipment(shipmentId: shipmentId),
        );
      case Routes.uploadNameAndNumberOfDriver:
        final id = arguments as int;
        return MaterialPageRoute(
          builder:
              (_) => UploadNumberImageAndNameOfDriverShipment(shipmentId: id),
        );
      case Routes.editCountry:
        final id = arguments as int;
        return MaterialPageRoute(
          builder:
              (_) => MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create:
                        (context) => UpdateShipmentOriginCountryCubit(
                          sl.get<UpdateShipmentOriginUseCase>(),
                        ),
                  ),
                  BlocProvider(
                    create:
                        (context) => UpdateShipmentDestenationCountryCubit(
                          sl.get<UpdateShipmentDestenationCountryUseCase>(),
                        ),
                  ),
                  BlocProvider(
                    create:
                        (context) =>
                            GetCountriesCubit(sl.get<GetCountriesUseCase>()),
                  ),
                ],
                child: CountrySwitchContainer(idShipment: id),
              ),
        );
      case Routes.createParcel:
        final id = arguments as int;
        return MaterialPageRoute(
          builder: (context) => CreateParcel(shipmentId: id),
        );
      case Routes.volumetricWeightCalculation:
        return MaterialPageRoute(
          builder: (context) => VolumetricWeightCalculation(),
        );
      case Routes.dimensionCalculation:
        return MaterialPageRoute(builder: (context) => DimensionCalculation());
      case Routes.createParcelItemScreen:
        final id = arguments as int;
        return MaterialPageRoute(
          builder:
              (context) => MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create:
                        (context) => CreateParcelItemCubit(
                          sl.get<CreateParcelItemUseCase>(),
                        ),
                  ),
                  BlocProvider(
                    create:
                        (context) => GetAllowedContentCubit(
                          sl.get<GetAllowedContentUseCase>(),
                        )..getContents(),
                  ),
                ],
                child: CreateParcelItemScreen(id: id),
              ),
        );
      case Routes.showParcelItemsScreen:
        final id = arguments as int;
        return MaterialPageRoute(
          builder:
              (context) => BlocProvider(
                create:
                    (context) =>
                        GetParcelItemsCubit(sl.get<GetParcelItemsUseCase>()),
                child: ShowParcelItemsScreen(id: id),
              ),
        );
      case Routes.updateShipmentsWarehouseArrivalScreen:
        final id = arguments as int;
        return MaterialPageRoute(
          builder:
              (context) => BlocProvider(
                create:
                    (context) => UpdateShipmentsWarehouseArrivalCubit(
                      sl.get<UpdateShipmentsWarehouseArrivalUseCase>(),
                    ),
                child: UpdateShipmentsWarehouseArrivalScreen(id: id),
              ),
        );
      case Routes.shipmentReceipt:
        final id = arguments as int;
        return MaterialPageRoute(
          builder:
              (context) => BlocProvider(
                create:
                    (context) => GetShipmentDetailsCubit(
                      sl.get<GetShipmentDetailsUseCase>(),
                    )..getShipmentDetails(idShipment: id),
                child: ShipmentReceipt(),
              ),
        );
      case Routes.showSpecificParcelsOfInTheWayShipments:
        final id = arguments as int;
        return MaterialPageRoute(
          builder:
              (context) =>
                  ShowSpecificParcelsOfInTheWayShipments(shipmentId: id),
        );
      case Routes.trackShipmentsHome:
        return MaterialPageRoute(builder: (_) => TrackShipmentsHome());
      case Routes.homeView:
        return MaterialPageRoute(builder: (context) => HomeView());
      case Routes.payTheBill:
        final shipment = arguments as ApprovedShipmentEntity;
        return MaterialPageRoute(
          builder: (context) => PayTheBill(approvedShipmentEntity: arguments),
        );
      case Routes.detailsOfBill:
        final id = arguments as int;
        return MaterialPageRoute(builder: (context) => DetailsOfBill(id: id));
      default:
        return null;
    }
  }
}
