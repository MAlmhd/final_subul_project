import 'package:final_subul_project/core/utils/functions/show_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:final_subul_project/core/helpers/assets_data.dart';
import 'package:final_subul_project/core/utils/service_locator.dart';
import 'package:final_subul_project/core/widgets/custom_progress_indicator.dart';
import 'package:final_subul_project/core/widgets/custom_search_item.dart';
import 'package:final_subul_project/features/get_unapproved_shipments/domain/use_case/approve_shipment_use_case/approve_shipment_use_case.dart';
import 'package:final_subul_project/features/get_unapproved_shipments/domain/use_case/get_unapproved_shipments_use_case/get_unapproved_shipments_use_case.dart';
import 'package:final_subul_project/features/get_unapproved_shipments/domain/use_case/reject_shipment_use_case/reject_shipment_use_case.dart';
import 'package:final_subul_project/features/get_unapproved_shipments/presentation/manager/approve_shipment_cubit/approve_shipment_cubit.dart';
import 'package:final_subul_project/features/get_unapproved_shipments/presentation/manager/get_unapproved_shipments_cubit/get_unapproved_shipments_cubit.dart';
import 'package:final_subul_project/features/get_unapproved_shipments/presentation/manager/reject_shipment_cubit/reject_shipment_cubit.dart';
import 'package:final_subul_project/features/get_unapproved_shipments/presentation/views/widgets/custom_shipment_item.dart';

class UnApprovedShipmentsScreen extends StatelessWidget {
  const UnApprovedShipmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) => GetUnapprovedShipmentsCubit(
                sl.get<GetUnapprovedShipmentsUseCase>(),
              )..getUnapprovedShipments(),
        ),
        BlocProvider(
          create:
              (context) =>
                  ApproveShipmentCubit(sl.get<ApproveShipmentUseCase>()),
        ),
        BlocProvider(
          create:
              (context) => RejectShipmentCubit(sl.get<RejectShipmentUseCase>()),
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<ApproveShipmentCubit, ApproveShipmentState>(
            listener: (context, state) {
              if (state is! ApproveShipmentLoading &&
                  Navigator.canPop(context)) {
                Navigator.pop(context);
              }
              if (state is ApproveShipmentSuccess) {
               showToastMsg(context, "تم الموافقة على الشحنة بنجاح");
                context
                    .read<GetUnapprovedShipmentsCubit>()
                    .getUnapprovedShipments();
              } else if (state is ApproveShipmentFailure) {
                showToastMsg(context, state.message);
              }
            },
          ),
          BlocListener<RejectShipmentCubit, RejectShipmentState>(
            listener: (context, state) {
              if (state is! RejectShipmentLoading &&
                  Navigator.canPop(context)) {
                Navigator.pop(context);
              }
              if (state is RejectShipmentSuccess) {
                 showToastMsg(context, "تم رفض الشحنة");
                context
                    .read<GetUnapprovedShipmentsCubit>()
                    .getUnapprovedShipments();
              } else if (state is RejectShipmentFailure) {
                 showToastMsg(context, state.message);
              }
            },
          ),
        ],
        child: Builder(
          builder: (context) {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 10.w),
                      child: CustomSearchItem(
                        svgPicture: SvgPicture.asset(AssetsData.searchIcon),
                        onChanged: (item) {
                          final query =
                              item.trim().isEmpty ? null : item.trim();
                          context
                              .read<GetUnapprovedShipmentsCubit>()
                              .getUnapprovedShipments(query);
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.height / 8),
                //   const TitleOfColumns(),
                SizedBox(height: size.height / 50),
                SizedBox(
                  height: 800.h,
                  child: BlocConsumer<
                    GetUnapprovedShipmentsCubit,
                    GetUnapprovedShipmentsState
                  >(
                    listener: (context, state) {
                      if (state is GetUnapprovedShipmentsFailure) {
                         showToastMsg(context, state.message);
                      }
                    },
                    builder: (context, state) {
                      if (state is GetUnapprovedShipmentsSuccess) {
                        return ListView.builder(
                          itemCount: state.shipments.length,
                          itemBuilder:
                              (context, index) => Padding(
                                padding: EdgeInsets.only(bottom: 12.h),
                                child: MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: CustomShipmentItem(
                                    unApprovedShipment: state.shipments[index],
                                  ),
                                ),
                              ),
                        );
                      } else {
                        return const CustomProgressIndicator();
                      }
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
