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
            showSnackBar(context, state.message, Colors.red);
          }
        },
        builder: (context, state) {
          if (state is GetShipmentsInTheWayLoading) {
            return const CustomProgressIndicator();
          } else if (state is GetShipmentsInTheWaySuccess) {
            return Padding(
              padding: EdgeInsets.only(top: 200.h),
              child: Column(
                children: [
                  //  TitlesOfShipments(),
                  SizedBox(height: 2.h),
                  SizedBox(
                    height: 800.h,
                    width: 500.w,
                    child: ListView.builder(
                      itemCount: state.shipments.length,
                      itemBuilder:
                          (context, index) => ShipmentInfoCard(
                            shipment: state.shipments[index],
                          ),
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
