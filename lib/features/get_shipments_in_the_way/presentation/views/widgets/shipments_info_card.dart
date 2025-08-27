import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:final_subul_project/core/helpers/constants.dart';
import 'package:final_subul_project/core/helpers/extensions.dart';
import 'package:final_subul_project/core/helpers/styles.dart';
import 'package:final_subul_project/core/routing/routes.dart';
import 'package:final_subul_project/core/theming/app_colors.dart';
import 'package:final_subul_project/features/get_shipments_in_the_way/domain/entity/shipment_in_the_way_entity/shipment_in_the_way_entity.dart';

// ✅ عرض البيانات في صفوف أفقية متراصة مع ترويسة ثابتة
class ShipmentInfoCard extends StatelessWidget {
  final ShipmentInTheWayEntity? shipment;

  const ShipmentInfoCard({super.key, this.shipment});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: ()
          {
             context.pushNamed(
                          Routes.updateShipmentsWarehouseArrivalScreen,
                          arguments: shipment!.id,
                        );
          },
          child: Padding(
            padding: EdgeInsets.all(10.h),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: AppColors.lightGray2,
                borderRadius: BorderRadius.circular(cornerRadius),
              ),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Row(
                  children: [
                   Expanded(flex: 3, child: _buildCell(shipment!.trackingNumber)),
      Expanded(flex: 2, child: _buildCell(shipment!.originCountry)),
      Expanded(flex: 2, child: _buildCell(shipment!.destinationCountry)),
      Expanded(flex: 1, child: _buildCell(shipment!.actualParcelsCount.toString())),
      Expanded(flex: 2, child: _buildCell(shipment!.customerName)), // لا تمررها على _formatDate
      Expanded(flex: 2, child: _buildCell(shipment!.status)),
      Expanded(flex: 2, child: _buildCell(shipment!.type)),
                          
                    // PopupMenuButton<String>(
                    //   icon: Icon(Icons.more_vert, color: Colors.black87),
                    //   shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(12),
                    //   ),
                    //   onSelected: (value) {
                    //     switch (value) {
                    //       case 'update':
                           
                    //         break;
                    //       case 'parcels':
                    //        
                    //         break;
                    //     }
                    //   },
                    //   itemBuilder:
                    //       (context) => [
                    //         PopupMenuItem(
                    //           value: 'update',
                    //           child: Text('تحديث  الشحنة'),
                    //         ),
                    //         PopupMenuItem(
                    //           value: 'parcels',
                    //           child: Text('عرض الطرود'),
                    //         ),
                    //       ],
                    // ),
                  ],
                ),
              ),
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
