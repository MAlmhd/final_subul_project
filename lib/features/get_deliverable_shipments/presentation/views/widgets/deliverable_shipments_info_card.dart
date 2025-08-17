import 'package:final_subul_project/core/helpers/extensions.dart';
import 'package:final_subul_project/core/routing/routes.dart';
import 'package:final_subul_project/features/get_deliverable_shipments/domain/entities/get_deliverable_shipments_entity/get_deliverable_shipments_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:final_subul_project/core/helpers/constants.dart';
import 'package:final_subul_project/core/helpers/styles.dart';
import 'package:final_subul_project/core/theming/app_colors.dart';

// ✅ عرض البيانات في صفوف أفقية متراصة مع ترويسة ثابتة
class DeliverableShipmentsInfoCard extends StatelessWidget {
  final GetDeliverableShipmentsEntity? shipment;

  const DeliverableShipmentsInfoCard({super.key, this.shipment});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(10.h),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: AppColors.lightGray2,
              borderRadius: BorderRadius.circular(cornerRadius),
            ),
            child: Row(
              children: [
                Expanded(flex: 3, child: _buildCell(shipment!.trackingNumber)),
                Expanded(flex: 2, child: _buildCell(shipment!.customerName)),
                Expanded(flex: 2, child: _buildCell(shipment!.customerCode)),

                Expanded(
                  flex: 2,
                  child: _buildCell(_formatDate(shipment!.shipmentCreatedAt)),
                ),
                PopupMenuButton<String>(
                  icon: Icon(Icons.more_vert, color: Colors.black87),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  onSelected: (value) {
                    switch (value) {
                      case 'mark':
                        context.pushNamed(
                          Routes.markShipmentDeliveredScreen,
                          arguments: shipment!.shipmentId,
                        );
                        break;

                      case 'invoice':
                        context.pushNamed(
                          Routes.invoiceDetailsPage,
                          arguments: shipment!.shipmentId,
                        );
                        break;
                    }
                  },
                  itemBuilder:
                      (context) => [
                        PopupMenuItem(
                          value: 'mark',
                          child: Text('علامة تسليم الشحنة'),
                        ),
                        PopupMenuItem(
                          value: 'invoice',
                          child: Text('تفاصيل الفاتورة'),
                        ),
                      ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCell(String value) {
    return Text(
      value,
      style: Styles.textStyle5Sp.copyWith(color: Colors.black),
      overflow: TextOverflow.ellipsis,
    );
  }

  String _formatDate(String isoDate) {
    try {
      final date = DateTime.parse(isoDate);
      return '${date.year}-${date.month}-${date.day}';
    } catch (_) {
      return isoDate;
    }
  }
}
