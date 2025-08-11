import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:final_subul_project/core/helpers/styles.dart';
import 'package:final_subul_project/core/theming/app_colors.dart';
import 'package:final_subul_project/core/utils/functions/show_snack_bar.dart';
import 'package:final_subul_project/core/utils/service_locator.dart';
import 'package:final_subul_project/core/widgets/custom_progress_indicator.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/use_case/get_shipment_parcels_use_case/get_shipment_parcels_use_case.dart';
import 'package:final_subul_project/features/get_shipment_in_process/presentation/manager/get_shipment_parcels_cubit/get_shipment_parcels_cubit.dart';
import 'package:final_subul_project/features/get_shipments_in_the_way/presentation/views/widgets/custom_parcel_of_in_the_way_shipments.dart';
import 'package:final_subul_project/features/warehouse_manager/ui/widgets/name_of_columns_in_show_all_shipments_table.dart';

class ShowSpecificParcelsOfInTheWayShipments extends StatelessWidget {
  final int shipmentId;
  const ShowSpecificParcelsOfInTheWayShipments({
    super.key,
    required this.shipmentId,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(backgroundColor: AppColors.grey),
      body: BlocProvider(
        create:
            (context) =>
                GetShipmentParcelsCubit(sl.get<GetShipmentParcelsUseCase>())
                  ..getShipmentParcels(shipmentId: shipmentId),
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,

            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.grey, AppColors.white],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 30.h,
                    ),
                    child: SizedBox(
                      width: 600.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 60.w,
                            child: Text(
                              'عرض جميع الطرود',
                              style: Styles.textStyle7Sp.copyWith(
                                color: AppColors.goldenYellow,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.clip,
                            ),
                          ),
                          // CustomSearchItem(
                          //   backgoundColor: AppColors.white,
                          //   hintText: 'فلترة من خلال',
                          //   icon: Icon(Icons.tune, color: AppColors.white),
                          //   textColor: AppColors.black,
                          // ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: size.height / 120),
                  NameOfColumnsInShowAllShipmentsTable(),
                  SizedBox(height: size.height / 30),
                  SizedBox(
                    height: 430.h,
                    width: 600.w,
                    child: BlocConsumer<
                      GetShipmentParcelsCubit,
                      GetShipmentParcelsState
                    >(
                      listener: (context, state) {
                        if (state is GetShipmentParcelsFailure) {
                          showSnackBar(context, state.message, Colors.red);
                        }
                      },
                      builder: (context, state) {
                        if (state is GetShipmentParcelsSuccess) {
                          return ListView.builder(
                            itemCount: state.parcels.length,
                            itemBuilder:
                                (context, index) => Padding(
                                  padding: EdgeInsets.only(bottom: 25.h),
                                  child: CustomParcelOfInTheWayShipments(
                                    id: state.parcels[index].id,
                                    shipmentId: state.parcels[index].shipmentId,
                                    actualWeight:
                                        state.parcels[index].actualWeight,
                                    specialActualWeight:
                                        state
                                            .parcels[index]
                                            .specialActualWeight,
                                    normalActualWeight:
                                        state.parcels[index].normalActualWeight,
                                    length: state.parcels[index].length,
                                    width: state.parcels[index].width,
                                    height: state.parcels[index].height,
                                    calculatedDimensionalWeight:
                                        state
                                            .parcels[index]
                                            .calculatedDimensionalWeight,
                                    calculatedFinalWeight:
                                        state
                                            .parcels[index]
                                            .calculatedFinalWeight,
                                    customerId: state.parcels[index].customerId,
                                    firstName: state.parcels[index].firstName,
                                    lastName: state.parcels[index].lastName,
                                  ),
                                ),
                          );
                        } else if (state is GetShipmentParcelsLoading) {
                          return CustomProgressIndicator();
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ),
                  // SizedBox(height: size.height / 50),
                  // Padding(
                  //   padding: EdgeInsets.only(right: 15.w),
                  //   child: SizedBox(
                  //     width: 40.w,
                  //     child: Text(
                  //       ':القيمة الإجمالية',
                  //       textAlign: TextAlign.center,
                  //       style: Styles.textStyle5Sp,
                  //       maxLines: 1,
                  //       overflow: TextOverflow.ellipsis,
                  //     ),
                  //   ),
                  // ),
                  // Padding(
                  //   padding: EdgeInsets.symmetric(
                  //     horizontal: 15.w,
                  //     vertical: 20.h,
                  //   ),

                  //   child: SizedBox(
                  //     width: 125.w,
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       children: [
                  //         Container(
                  //           width: 40.w,
                  //           height: 55.h,
                  //           padding: EdgeInsets.symmetric(
                  //             horizontal: 8.w,
                  //             vertical: 10.h,
                  //           ),
                  //           decoration: BoxDecoration(
                  //             color: AppColors.goldenYellow,
                  //             borderRadius: BorderRadius.circular(cornerRadius),
                  //           ),
                  //           child: Row(
                  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //             children: [
                  //               Text('إنشاء طرد', style: Styles.textStyle3Sp),
                  //               Icon(Icons.add, color: AppColors.white),
                  //             ],
                  //           ),
                  //         ),
                  //         Container(
                  //           width: 80.w,
                  //           height: 55.h,
                  //           decoration: BoxDecoration(
                  //             color: AppColors.goldenYellow,
                  //             borderRadius: BorderRadius.circular(cornerRadius),
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
