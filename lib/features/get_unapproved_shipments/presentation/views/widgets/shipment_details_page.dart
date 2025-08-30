import 'package:final_subul_project/core/helpers/extensions.dart';
import 'package:final_subul_project/core/routing/routes.dart';
import 'package:final_subul_project/features/get_unapproved_shipments/domain/use_case/approve_shipment_use_case/approve_shipment_use_case.dart';
import 'package:final_subul_project/features/get_unapproved_shipments/domain/use_case/reject_shipment_use_case/reject_shipment_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:final_subul_project/core/utils/service_locator.dart';
import 'package:final_subul_project/core/utils/functions/show_snack_bar.dart';

import 'package:final_subul_project/features/get_unapproved_shipments/presentation/manager/approve_shipment_cubit/approve_shipment_cubit.dart';
import 'package:final_subul_project/features/get_unapproved_shipments/presentation/manager/reject_shipment_cubit/reject_shipment_cubit.dart';

import 'package:final_subul_project/features/get_unapproved_shipments/domain/entities/un_approved_shipment_entity/un_approved_shipments_entity.dart';

import 'shipment_details_card.dart'; // ملف الودجت الذي أرسلته أنت

class ShipmentDetailsPage extends StatelessWidget {
  const ShipmentDetailsPage({super.key, required this.data});
  final UnApprovedShipmentsEntity data;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
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
          // استماع لنتائج الموافقة
          BlocListener<ApproveShipmentCubit, ApproveShipmentState>(
            listener: (context, state) {
              // اغلق لودر الـ Dialog إن كان مفتوح
              if (state is! ApproveShipmentLoading &&
                  Navigator.canPop(context)) {
                Navigator.pop(context);
              }

              if (state is ApproveShipmentSuccess) {
               // showToastMsg(context, "تم الموافقة على الشحنة بنجاح");

                // ✅ التنقّل حسب نوع الشحنة
                if (data.typeOfShipment == "pay_only" ||
                    data.typeOfShipment == "ship_pay") {
                  // الذهاب لصفحة الدفع/الفاتورة (مرّر ما تحتاجه)
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.pushNamed(
                      context,
                      Routes.payTheBillOfUnApprovedShipment,
                      arguments: data,
                    );
                  });
                } else if (data.typeOfShipment == "ship_only") {
                  // ✅ ارجع لصفحة القائمة ومعك نتيجة true
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.of(context).pop(true);
                  });
                }
              } else if (state is ApproveShipmentFailure) {
                showToastMsg(context, state.message);
              }
            },
          ),
          // استماع لنتائج الرفض
          BlocListener<RejectShipmentCubit, RejectShipmentState>(
            listener: (context, state) {
              if (state is! RejectShipmentLoading &&
                  Navigator.canPop(context)) {
                Navigator.pop(context);
              }
              if (state is RejectShipmentSuccess) {
               WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.of(context).pop(true);
                  });
                //  context.read<GetUnapprovedShipmentsCubit>().getUnapprovedShipments();
                // if (Navigator.canPop(context)) Navigator.pop(context);
              } else if (state is RejectShipmentFailure) {
                showToastMsg(context, state.message);
              }
            },
          ),
        ],
        // ابنِ كارت التفاصيل كما هو (يستعمل Cubits من الأعلى)
        child: ShipmentDetailsCard(data: data),
      ),
    );
  }
}
