import 'package:final_subul_project/core/data/auth_local_data_source.dart';
import 'package:final_subul_project/core/helpers/assets_data.dart';
import 'package:final_subul_project/core/helpers/extensions.dart';
import 'package:final_subul_project/core/routing/routes.dart';
import 'package:final_subul_project/core/theming/app_colors.dart';
import 'package:final_subul_project/core/utils/service_locator.dart';
import 'package:final_subul_project/core/widgets/custom_icon_of_side_bar.dart';
import 'package:final_subul_project/core/widgets/refetch_on_show.dart';
import 'package:final_subul_project/core/widgets/text_logo.dart';
import 'package:final_subul_project/features/create_shipment/domain/use_case/create_shipment_use_case/create_shipment_use_case.dart';
import 'package:final_subul_project/features/create_shipment/domain/use_case/get_countries_use_case/get_countries_use_case.dart';
import 'package:final_subul_project/features/create_shipment/domain/use_case/get_suppliers_use_case/get_suppliers_use_case.dart';
import 'package:final_subul_project/features/create_shipment/domain/use_case/get_users_use_case/get_user_use_case.dart';
import 'package:final_subul_project/features/create_shipment/presentation/manager/create_shipment_cubit/create_shipment_cubit.dart';
import 'package:final_subul_project/features/create_shipment/presentation/manager/get_countries_cubit/get_countries_cubit.dart';
import 'package:final_subul_project/features/create_shipment/presentation/manager/get_suppliers_cubit/get_suppliers_cubit.dart';
import 'package:final_subul_project/features/create_shipment/presentation/manager/get_users_cubit/get_users_cubit.dart';
import 'package:final_subul_project/features/create_shipment/presentation/views/add_shipment_form.dart';
import 'package:final_subul_project/features/get_deliverable_shipments/domain/use_case/get_deliverable_shipments_use_case/get_deliverable_shipments_use_case.dart';
import 'package:final_subul_project/features/get_deliverable_shipments/presentation/managers/get_deliverable_shipments_cubit/get_deliverable_shipments_cubit.dart';
import 'package:final_subul_project/features/get_deliverable_shipments/presentation/views/show_deliverable_shipments_screen.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/use_case/get_shipments_in_process_use_case/get_shipments_in_process_use_case.dart';
import 'package:final_subul_project/features/get_shipment_in_process/presentation/manager/get_shipments_in_process_cubit/get_shipment_in_proccess_cubit.dart';
import 'package:final_subul_project/features/get_shipment_in_process/presentation/views/show_shipments_in_process_screen.dart';
import 'package:final_subul_project/features/get_shipments_in_the_way/domain/use_case/get_shipments_in_the_way_use_case/get_shipments_in_the_way_use_case.dart';
import 'package:final_subul_project/features/get_shipments_in_the_way/presentation/manager/get_shipments_in_the_way_cubit/get_shipments_in_the_way_cubit.dart';
import 'package:final_subul_project/features/get_shipments_in_the_way/presentation/views/get_shipments_in_the_way_screen.dart';
import 'package:final_subul_project/features/home_view/presentation/views/widgets/animations.dart';
import 'package:final_subul_project/features/warehouse_manager/manager/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WarehouseManager extends StatefulWidget {
  const WarehouseManager({super.key});

  @override
  State<WarehouseManager> createState() => _WarehouseManagerState();
}

class _WarehouseManagerState extends State<WarehouseManager> {
  int selectedButtonIndex = 0;
  void onButtonTap(int index) {
    setState(() {
      selectedButtonIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.grey, AppColors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Row(
          children: [
            Stack(
              children: [
                BlocProvider(
                  create: (context) => AuthCubit(sl<AuthLocalDataSource>()),
                  child: Builder(
                    builder:
                        (context) => Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 10.w, top: 40.h),
                              child: TextLogo(),
                            ),
                            SizedBox(height: size.height / 30),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.goldenYellow,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(120),
                                    topLeft: Radius.circular(10),
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(height: 35.h),
                                    CustomIconOfSideBar(
                                      icon: Icons.add,
                                      color: AppColors.white,
                                      onTap: () {
                                        onButtonTap(1);
                                      },
                                      isSelected: selectedButtonIndex == 1,
                                    ),
                                    SizedBox(height: 24.h),
                                    CustomIconOfSideBar(
                                      icon: Icons.local_shipping,
                                      color: AppColors.white,
                                      onTap: () {
                                        onButtonTap(2);
                                      },
                                      isSelected: selectedButtonIndex == 2,
                                    ),
                                    SizedBox(height: 24.h),
                                    CustomIconOfSideBar(
                                      image: AssetsData.boxShipmmentIcon,
                                      onTap: () {
                                        onButtonTap(3);
                                      },
                                      isSelected: selectedButtonIndex == 3,
                                    ),
                                    SizedBox(height: 24.h),
                                    CustomIconOfSideBar(
                                      image: AssetsData.outlinePurpleBox,
                                      onTap: () {
                                        onButtonTap(4);
                                      },
                                      isSelected: selectedButtonIndex == 4,
                                    ),
                                    SizedBox(height: 24.h),
                                    BlocListener<AuthCubit, AuthState>(
                                      listener: (context, state) {
                                        if (state is AuthLoggedOut) {
                                          if (!context.mounted) return;
                                          Navigator.of(
                                            context,
                                          ).pushNamedAndRemoveUntil(
                                            Routes.signInScreen,
                                            (route) => false,
                                          );
                                        }
                                      },
                                      child: Tooltip(
                                        message: 'تسجيل الخروج',
                                        child: Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                              bottom: 20,
                                            ),
                                            child: InkWell(
                                              onTap: () async {
                                                context
                                                    .read<AuthCubit>()
                                                    .logout();
                                              },
                                              child: Container(
                                                width: 50,
                                                height: 50,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  gradient:
                                                      const LinearGradient(
                                                        colors: [
                                                          AppColors.richPurple,
                                                          AppColors
                                                              .goldenYellow,
                                                          AppColors
                                                              .vibrantOrange,
                                                          AppColors.deepPurple,
                                                        ],
                                                        stops: [
                                                          0.25,
                                                          0.5,
                                                          0.75,
                                                          1.0,
                                                        ],
                                                        begin:
                                                            Alignment
                                                                .centerLeft,
                                                        end:
                                                            Alignment
                                                                .centerRight,
                                                      ),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black26,
                                                      blurRadius: 6,
                                                      offset: Offset(0, 3),
                                                    ),
                                                  ],
                                                ),
                                                child: const Icon(
                                                  Icons.logout,
                                                  color: Colors.white,
                                                  size: 28,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: IndexedStack(
                index: selectedButtonIndex,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 200.h),
                    child: Animations(),
                  ),
                  MultiBlocProvider(
                    providers: [
                      BlocProvider(
                        create:
                            (context) =>
                                GetUsersCubit(sl.get<GetUserUseCase>()),
                      ),
                      BlocProvider(
                        create:
                            (context) => GetCountriesCubit(
                              sl.get<GetCountriesUseCase>(),
                            ),
                      ),
                      BlocProvider(
                        create:
                            (context) => CreateShipmentCubit(
                              sl.get<CreateShipmentUseCase>(),
                            ),
                      ),
                      BlocProvider(
                        create:
                            (context) => GetSuppliersCubit(
                              sl.get<GetSuppliersUseCase>(),
                            ),
                      ),
                    ],
                    child: AddShipmentForm(),
                  ),
                  BlocProvider(
                    create:
                        (context) => GetShipmentInProccessCubit(
                          sl.get<GetShipmentsInProcessUseCase>(),
                        )..getShipments(),
                    child: Builder(
                      builder:
                          (context) => RefetchOnShow(
                            isVisible: selectedButtonIndex == 1,
                            onShow:
                                () =>
                                    context.read<GetShipmentInProccessCubit>()
                                      ..getShipments(),
                            child: ShowShipmentsInProcessScreen(),
                          ),
                    ),
                  ),
                  BlocProvider(
                    create:
                        (context) => GetShipmentsInTheWayCubit(
                          sl.get<GetShipmentsInTheWayUseCase>(),
                        )..getShipmentsInTheWay(),
                    child: Builder(
                      builder:
                          (context) => RefetchOnShow(
                            isVisible: selectedButtonIndex == 2,
                            onShow:
                                () =>
                                    context.read<GetShipmentsInTheWayCubit>()
                                      ..getShipmentsInTheWay(),
                            child: GetShipmentsInTheWayScreen(),
                          ),
                    ),
                  ),
                  BlocProvider(
                    create:
                        (context) => GetDeliverableShipmentsCubit(
                          sl.get<GetDeliverableShipmentsUseCase>(),
                        ),
                    child: Builder(
                      builder:
                          (context) => RefetchOnShow(
                            isVisible: selectedButtonIndex == 3,
                            onShow:
                                () =>
                                    context
                                        .read<GetDeliverableShipmentsCubit>()
                                        .getDeliverableShipments(), // سمّها حسب دالتك
                            child: const ShowDeliverableShipmentsScreen(),
                          ),
                    ),
                  ),

                  // BlocProvider(
                  //   create:
                  //       (context) =>
                  //           GetAllParcelsCubit(sl.get<GetAllParcelsUseCase>())
                  //             ..getAllParcels(),
                  //   child: ShowAllParcels(),
                  // ),
                  // EditReceivingShipmentsTable(
                  //   widget: CustomOkButton(
                  //     onTap: () {},
                  //     color: AppColors.goldenYellow,
                  //     label: 'تعديل',
                  //   ),
                  // ),
                  // EditShippingDetail(),
                  //  LogisticsEntryScreen(),
                  // SubulReceiptScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
