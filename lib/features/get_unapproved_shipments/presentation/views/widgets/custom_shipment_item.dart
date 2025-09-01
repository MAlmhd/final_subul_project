import 'package:final_subul_project/core/helpers/extensions.dart';
import 'package:final_subul_project/core/routing/routes.dart';
import 'package:final_subul_project/features/get_unapproved_shipments/presentation/manager/get_unapproved_shipments_cubit/get_unapproved_shipments_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:final_subul_project/core/helpers/assets_data.dart';
import 'package:final_subul_project/core/helpers/constants.dart';
import 'package:final_subul_project/core/helpers/styles.dart';
import 'package:final_subul_project/core/theming/app_colors.dart';
import 'package:final_subul_project/features/get_unapproved_shipments/domain/entities/un_approved_shipment_entity/un_approved_shipments_entity.dart';

class CustomShipmentItem extends StatefulWidget {
  const CustomShipmentItem({super.key, required this.unApprovedShipment});
  final UnApprovedShipmentsEntity unApprovedShipment;

  @override
  State<CustomShipmentItem> createState() => _CustomShipmentItemState();
}

class _CustomShipmentItemState extends State<CustomShipmentItem> {
  final TextEditingController reasonController = TextEditingController();

  @override
  void dispose() {
    reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      child: GestureDetector(
        onTap: () async {
          final result = await Navigator.pushNamed(
            context,
            Routes.shipmentDetailsPage,
            arguments: widget.unApprovedShipment,
          );

          if (context.mounted && result == true) {
            // ✅ جدّد الشحنات بعد الرجوع من صفحة التفاصيل
            context
                .read<GetUnapprovedShipmentsCubit>()
                .getUnapprovedShipments();
          }
        },
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                height: 90.h,
                decoration: BoxDecoration(
                  color: AppColors.lightGray2,
                  borderRadius: BorderRadius.circular(cornerRadius),
                ),
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: Row(
                  children: [
                    Container(
                      width: 30.w,
                      height: 35.h,
                      decoration: BoxDecoration(
                        color:
                            widget.unApprovedShipment.statusOfShipment == null
                                ? Colors.red
                                : AppColors.green,
                        borderRadius: BorderRadius.circular(cornerRadius),
                      ),
                      child: Center(
                        child: Text(
                          widget.unApprovedShipment.statusOfShipment ?? "",
                          style: Styles.textStyle4Sp,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      widget.unApprovedShipment.numberOfShipments.toString(),
                      style: Styles.textStyle5Sp,
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Text(
                        widget.unApprovedShipment.nameOfCustomer,
                        style: Styles.textStyle5Sp,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Tooltip(
                        message:widget.unApprovedShipment.trackingString ,
                        child: Text(
                          widget.unApprovedShipment.trackingString,
                          style: Styles.textStyle5Sp,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),

                    // IconButton(
                    //   icon: const Icon(Icons.check_circle, color: Colors.green),
                    //   tooltip: 'الموافقة',
                    //   onPressed: () {

                    //   },
                    // ),
                    // IconButton(
                    //   icon: const Icon(Icons.cancel, color: Colors.red),
                    //   tooltip: 'رفض',
                    //   onPressed: () {
                  ],
                ),
              ),
            ),
            SizedBox(width: 10.w),
            SvgPicture.asset(AssetsData.box, width: 70.w, height: 70.h),
          ],
        ),
      ),
    );
  }
}
