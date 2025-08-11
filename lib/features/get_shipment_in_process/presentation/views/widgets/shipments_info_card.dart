import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:final_subul_project/core/helpers/constants.dart';
import 'package:final_subul_project/core/helpers/extensions.dart';
import 'package:final_subul_project/core/helpers/styles.dart';
import 'package:final_subul_project/core/routing/routes.dart';
import 'package:final_subul_project/core/theming/app_colors.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/entities/shipment_in_process_entity/shipment_in_process_entity.dart';

// ✅ عرض البيانات في صفوف أفقية متراصة مع ترويسة ثابتة
class ShipmentInfoCard extends StatelessWidget {
  final ShipmentInProcessEntity? shipment;

  const ShipmentInfoCard({super.key, this.shipment});

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
                Expanded(flex: 2, child: _buildCell(shipment!.originCountry)),
                Expanded(
                  flex: 2,
                  child: _buildCell(shipment!.destinationCountry),
                ),
                Expanded(
                  flex: 1,
                  child: _buildCell(shipment!.declaredParcelsCount.toString()),
                ),
                Expanded(
                  flex: 2,
                  child: _buildCell(_formatDate(shipment!.dateOfShipment)),
                ),
                PopupMenuButton<String>(
                  icon: Icon(Icons.more_vert, color: Colors.black87),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  onSelected: (value) {
                    switch (value) {
                      case 'details':
                        context.pushNamed(
                          Routes.shipmentReceipt,
                          arguments: shipment!.id,
                        );
                        break;

                      case 'driver':
                        context.pushNamed(
                          Routes.uploadNameAndNumberOfDriver,
                          arguments: shipment!.id,
                        );
                        break;
                      case 'edit':
                        context.pushNamed(
                          Routes.editCountry,
                          arguments: shipment!.id,
                        );
                        break;
                      case 'parcels':
                        context.pushNamed(
                          Routes.showParcelsOfSpecificShipment,
                          arguments: shipment!.id,
                        );
                        break;
                      case 'create parcel':
                        context.pushNamed(
                          Routes.createParcel,
                          arguments: shipment!.id,
                        );
                        break;
                    }
                  },
                  itemBuilder:
                      (context) => [
                        PopupMenuItem(
                          value: 'details',
                          child: Text('عرض التفاصيل'),
                        ),
                        PopupMenuItem(
                          value: 'driver',
                          child: Text('تعيين سائق'),
                        ),
                        PopupMenuItem(
                          value: 'edit',
                          child: Text('تعديل الشحنة'),
                        ),
                        PopupMenuItem(
                          value: 'parcels',
                          child: Text('عرض الطرود'),
                        ),
                        PopupMenuItem(
                          value: 'create parcel',
                          child: Text('انشاء طرود'),
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
