import 'package:final_subul_project/features/get_shipments_in_the_way/presentation/views/widgets/custom_track_shipment_item.dart';
import 'package:final_subul_project/features/get_shipments_in_the_way/presentation/views/widgets/titles_of_shipments.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:final_subul_project/core/utils/functions/show_snack_bar.dart';
import 'package:final_subul_project/core/widgets/custom_progress_indicator.dart';
import 'package:final_subul_project/features/get_shipments_in_the_way/presentation/manager/get_shipments_in_the_way_cubit/get_shipments_in_the_way_cubit.dart';
import 'package:final_subul_project/features/get_shipments_in_the_way/presentation/views/widgets/shipments_info_card.dart';

class GetShipmentsInTheWayScreen extends StatelessWidget {
  const GetShipmentsInTheWayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<GetShipmentsInTheWayCubit, GetShipmentsInTheWayState>(
        listener: (context, state) {
          if (state is GetShipmentsInTheWayFailure) {
            showToastMsg(context, state.message);
          }
        },
        builder: (context, state) {
          if (state is GetShipmentsInTheWayLoading) {
            return const CustomProgressIndicator();
          } else if (state is GetShipmentsInTheWaySuccess) {
            return Padding(
              // مسافة بسيطة بدل 200.h لتفادي مشاكل القيود
              padding: EdgeInsets.only(top: 200.h),
              child: Column(
                children: [
                  // عنوان ثابت خارج السكرول
                 // const TitlesOfShipments(),
                  SizedBox(height: 8.h),

                  // القائمة فقط هي التي تسكرول
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.shipments.length,
                      itemBuilder: (context, index) {
                        return CustomTrackShipmentItem(
                          shipmentInTheWayEntity: state.shipments[index],
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: Text("لا توجد بيانات حالياً"));
          }
        },
      ),
    );
  }
}
