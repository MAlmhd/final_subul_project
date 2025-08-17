import 'package:final_subul_project/core/utils/functions/show_snack_bar.dart';
import 'package:final_subul_project/core/widgets/custom_progress_indicator.dart';
import 'package:final_subul_project/features/get_deliverable_shipments/presentation/managers/get_deliverable_shipments_cubit/get_deliverable_shipments_cubit.dart';
import 'package:final_subul_project/features/get_deliverable_shipments/presentation/views/widgets/deliverable_shipments_info_card.dart';
import 'package:final_subul_project/features/get_deliverable_shipments/presentation/views/widgets/titles_of_delivered_shipments.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShowDeliverableShipmentsScreen extends StatefulWidget {
  const ShowDeliverableShipmentsScreen({super.key});

  @override
  State<ShowDeliverableShipmentsScreen> createState() =>
      _ShowDeliverableShipmentsScreenState();
}

class _ShowDeliverableShipmentsScreenState
    extends State<ShowDeliverableShipmentsScreen> {
  @override
  void initState() {
    // context.read<GetDeliverableShipmentsCubit>().getDeliverableShipments();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<
        GetDeliverableShipmentsCubit,
        GetDeliverableShipmentsState
      >(
        builder: (context, state) {
          if (state is GetDeliverableShipmentsLoading) {
            return CustomProgressIndicator();
          } else if (state is GetDeliverableShipmentsSuccess) {
            return Padding(
              padding: EdgeInsets.only(top: 200.h),
              child: Column(
                children: [
                  TitlesOfDeliveredShipments(),
                  SizedBox(height: 2.h),
                  SizedBox(
                    height: 800.h,
                    width: 500.w,
                    child: ListView.builder(
                      itemCount: state.shipments.length,
                      itemBuilder:
                          (context, index) => DeliverableShipmentsInfoCard(
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
        listener: (context, state) {
          if (state is GetDeliverableShipmentsFailure) {
            showSnackBar(context, state.message, Colors.red);
          }
        },
      ),
    );
  }
}
