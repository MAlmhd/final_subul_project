import 'package:final_subul_project/core/helpers/extensions.dart';
import 'package:final_subul_project/core/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:final_subul_project/core/theming/app_colors.dart';
import 'package:final_subul_project/core/utils/service_locator.dart';
import 'package:final_subul_project/features/track_shipments_home/domain/use_case/get_approved_shipments_use_case/get_approved_shipments_use_case.dart';
import 'package:final_subul_project/features/track_shipments_home/presentation/manager/get_approved_shipment/get_approved_shipment_cubit.dart';
import 'package:final_subul_project/features/track_shipments_home/presentation/views/widgets/show_shippments.dart';

class TrackShipmentsHome extends StatelessWidget {
  const TrackShipmentsHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.grey,
        leading: IconButton(
          onPressed: () {
            context.pushNamedAndRemoveUntil(
              Routes.homeView,
              predicate: (Route<dynamic> route) => false,
            );
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.grey, AppColors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: BlocProvider(
            create:
                (context) => GetApprovedShipmentCubit(
                  sl.get<GetApprovedShipmentsUseCase>(),
                )..getApprovedShipments(),
            child: ShowShippments(),
          ),
        ),
      ),
    );
  }
}
