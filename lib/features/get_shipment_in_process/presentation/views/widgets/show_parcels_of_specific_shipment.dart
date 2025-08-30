import 'dart:developer';

import 'package:final_subul_project/core/helpers/extensions.dart';
import 'package:final_subul_project/core/routing/routes.dart';
import 'package:final_subul_project/core/widgets/custom_ok_button.dart';
import 'package:final_subul_project/features/get_shipment_in_process/presentation/manager/get_shipment_parcels_cubit/get_shipment_parcels_cubit.dart';
import 'package:final_subul_project/features/get_shipment_in_process/presentation/manager/get_shipment_parcels_cubit/get_shipment_parcels_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:final_subul_project/core/helpers/constants.dart';
import 'package:final_subul_project/core/helpers/styles.dart';
import 'package:final_subul_project/core/theming/app_colors.dart';
import 'package:final_subul_project/core/utils/functions/show_snack_bar.dart';
import 'package:final_subul_project/core/utils/service_locator.dart';
import 'package:final_subul_project/core/widgets/custom_progress_indicator.dart';
import 'package:final_subul_project/features/get_shipment_in_process/presentation/views/widgets/custom_item_in_show_all_parcels_table.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/use_case/get_shipment_parcels_use_case/get_shipment_parcels_use_case.dart';

class ShowParcelsOfSpecificShipment extends StatelessWidget {
  final int shipmentId;
  final int numberOfParcels;

  const ShowParcelsOfSpecificShipment({
    super.key,
    required this.shipmentId,
    required this.numberOfParcels,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (_) =>
              GetShipmentParcelsCubit(sl.get<GetShipmentParcelsUseCase>())
                ..getShipmentParcels(shipmentId: shipmentId),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.grey,
          automaticallyImplyLeading: true,
        ),
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.grey, AppColors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: BlocConsumer<GetShipmentParcelsCubit, GetShipmentParcelsState>(
            listener: (context, state) {
              if (state is GetShipmentParcelsFailure) {
                showToastMsg(context, state.message);
              }
            },
            builder: (context, state) {
              if (state is GetShipmentParcelsLoading) {
                return const Center(child: CustomProgressIndicator());
              }

              if (state is GetShipmentParcelsSuccess) {
                final parcels = state.parcels.parcels;

                return Column(
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
                              width: 160.w,
                              child: Text(
                                'عرض جميع الطرود',
                                style: Styles.textStyle7Sp.copyWith(
                                  color: AppColors.goldenYellow,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.clip,
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // // شريط رؤوس الأعمدة (اختياري تحسيني)
                    // Padding(
                    //   padding: EdgeInsets.symmetric(horizontal: 10.w),
                    //   child: SingleChildScrollView(
                    //     scrollDirection: Axis.horizontal,
                    //     child: Container(
                    //       width: 600.w,
                    //       padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                    //       decoration: BoxDecoration(
                    //         color: AppColors.white.withOpacity(0.8),
                    //         borderRadius: BorderRadius.circular(cornerRadius),
                    //       ),
                    //       child: Row(
                    //         children: [
                    //           _HeaderCell('ID', width: 60.w),
                    //           _HeaderCell('العميل', width: 160.w),
                    //           _HeaderCell('الوزن', width: 80.w),
                    //           _HeaderCell('الأبعاد (ط×ع×ا)', width: 180.w),
                    //           _HeaderCell('الحالة', width: 100.w),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    SizedBox(height: 12.h),

                    Expanded(
                      child: SizedBox(
                        width: 600.w,
                        child:
                            parcels.isEmpty
                                ? Center(
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 40.h),
                                    child: Text(
                                      'لا توجد طرود لهذا الشحنة.',
                                      style: Styles.textStyle5Sp.copyWith(
                                        color: AppColors.black,
                                      ),
                                    ),
                                  ),
                                )
                                : ListView.builder(
                                  itemCount: parcels.length,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10.w,
                                    vertical: 8.h,
                                  ),
                                  itemBuilder: (context, index) {
                                    final p = parcels[index];
                                    return Padding(
                                      padding: EdgeInsets.only(bottom: 12.h),
                                      child: CustomItemInShowAllShipmentsTable(
                                        id: p.id,
                                        shipmentId: shipmentId,
                                        actualWeight: p.actualWeight.toString(),
                                        length: p.length,
                                        width: p.width,
                                        height: p.height,
                                        customerId: p.customerId,
                                        firstName: p.firstName,
                                        lastName: p.lastName,
                                      ),
                                    );
                                  },
                                ),
                      ),
                    ),

                    SizedBox(height: 8.h),

                    if (state.parcels.createdParcelsCount <
                        state.parcels.declaredParcelsCount)
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 15.w,
                          vertical: 16.h,
                        ),
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () async {
                              final result = await context.pushNamed(
                                Routes.createParcel,
                                arguments: {
                                  "id": shipmentId,
                                  "numberOfParcels":
                                      state
                                          .parcels
                                          .declaredParcelsCount, // المطلوب الكلي
                                  "numberOfCreatedParcels":
                                      state
                                          .parcels
                                          .createdParcelsCount, // الموجود مسبقًا
                                },
                              );

                              // (اختياري) لو رجعت بنتيجة refresh
                              if (result is Map &&
                                  result['refresh'] == true &&
                                  context.mounted) {
                                context
                                    .read<GetShipmentParcelsCubit>()
                                    .getShipmentParcels(shipmentId: shipmentId);
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12.w,
                                    vertical: 10.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.goldenYellow,
                                    borderRadius: BorderRadius.circular(
                                      cornerRadius,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        'إنشاء طرد',
                                        style: Styles.textStyle3Sp,
                                      ),
                                      SizedBox(width: 8.w),
                                      Icon(Icons.add, color: AppColors.white),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    else
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 15.w,
                          vertical: 16.h,
                        ),
                        child: CustomOkButton(
                          onTap: () {
                            log("createdParcelsCount = ${state.parcels.createdParcelsCount}");
                            context.pushNamed(
                              Routes.uploadNameAndNumberOfDriver,
                              arguments: {
                                "id": shipmentId,
                                "numberOfParcels":
                                    state.parcels.createdParcelsCount,
                              },
                            );
                          },
                          color: AppColors.deepPurple,
                          label: "انهاء الشحنة",
                        ),
                      ),
                  ],
                );
              }

              // Initial أو أي حالة غير متوقعة
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}

class _HeaderCell extends StatelessWidget {
  final String title;
  final double width;
  const _HeaderCell(this.title, {required this.width, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Text(
        title,
        style: Styles.textStyle4Sp.copyWith(
          fontWeight: FontWeight.w700,
          color: AppColors.black,
        ),
        textAlign: TextAlign.start,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
