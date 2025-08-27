import 'package:final_subul_project/core/helpers/extensions.dart';
import 'package:final_subul_project/core/routing/routes.dart';
import 'package:final_subul_project/features/get_deliverable_shipments/domain/entities/get_deliverable_shipments_entity/get_deliverable_shipments_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:final_subul_project/core/helpers/styles.dart';
import 'package:final_subul_project/core/theming/app_colors.dart';

class CustomTrackShipmentItem extends StatelessWidget {
  const CustomTrackShipmentItem({
    super.key,
    required this.getDeliverableShipmentsEntity,
  });

  final GetDeliverableShipmentsEntity getDeliverableShipmentsEntity;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: AppColors.lightGray2,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          children: [
            const Icon(Icons.done, size: 18),
            SizedBox(width: 12.w),

            // كود الزبون
            Expanded(
              flex: 2,
              child: Tooltip(
                message: 'كود الزبون',
                child: Text(
                  getDeliverableShipmentsEntity.customerCode,
                  style: Styles.textStyle5Sp,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                ),
              ),
            ),
            SizedBox(width: 12.w),

            // اسم الزبون
            Expanded(
              flex: 3,
              child: Tooltip(
                message: 'اسم الزبون',
                child: Text(
                  getDeliverableShipmentsEntity.customerName,
                  style: Styles.textStyle4Sp,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                ),
              ),
            ),
            SizedBox(width: 12.w),

            // كود التتبع (طويل) — قص بالمحاذاة
            Expanded(
              flex: 4,
              child: Tooltip(
                message: 'كود التتبع',
                child: Text(
                  getDeliverableShipmentsEntity.trackingNumber,
                  style: Styles.textStyle5Sp,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  textAlign: TextAlign.start,
                ),
              ),
            ),
            SizedBox(width: 12.w),

            // التاريخ
            Expanded(
              flex: 3,
              child: Tooltip(
                message: 'تاريخ إنشاء الشحنة',
                child: Text(
                  _formatDate(getDeliverableShipmentsEntity.shipmentCreatedAt),
                  style: Styles.textStyle5Sp,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                ),
              ),
            ),

            // قائمة المزيد
            PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert, color: AppColors.black),
              onSelected: (value) {
                switch (value) {
                  case 'mark':
                    context.pushNamed(
                      Routes.markShipmentDeliveredScreen,
                      arguments: getDeliverableShipmentsEntity.shipmentId,
                    );
                    break;
                  case 'invoice':
                    context.pushNamed(
                      Routes.invoiceDetailsPage,
                      arguments: getDeliverableShipmentsEntity.shipmentId,
                    );
                    break;
                }
              },
              itemBuilder: (context) => const [
                PopupMenuItem(value: 'mark', child: Text('علامة تسليم الشحنة')),
                PopupMenuItem(value: 'invoice', child: Text('تفاصيل الفاتورة')),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(String iso) {
    try {
      final d = DateTime.parse(iso);
      final m = d.month.toString().padLeft(2, '0');
      final day = d.day.toString().padLeft(2, '0');
      return '${d.year}-$m-$day';
    } catch (_) {
      return iso;
    }
  }
}
