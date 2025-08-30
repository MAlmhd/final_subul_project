import 'package:final_subul_project/core/utils/functions/show_snack_bar.dart';
import 'package:final_subul_project/core/utils/service_locator.dart';
import 'package:final_subul_project/features/get_unapproved_shipments/domain/use_case/get_unapproved_shipments_use_case/get_unapproved_shipments_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:final_subul_project/core/helpers/assets_data.dart';
import 'package:final_subul_project/core/widgets/custom_progress_indicator.dart';
import 'package:final_subul_project/core/widgets/custom_search_item.dart';
import 'package:final_subul_project/features/get_unapproved_shipments/presentation/manager/get_unapproved_shipments_cubit/get_unapproved_shipments_cubit.dart';
import 'package:final_subul_project/features/get_unapproved_shipments/presentation/views/widgets/custom_shipment_item.dart';

class UnApprovedShipmentsScreen extends StatelessWidget {
  const UnApprovedShipmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Builder(
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
                      final query = item.trim().isEmpty ? null : item.trim();
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
    );
  }
}
