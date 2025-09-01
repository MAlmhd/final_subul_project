import 'package:final_subul_project/features/get_shipment_in_process/domain/entities/shipment_in_process_entity/shipment_in_process_entity.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:final_subul_project/core/helpers/assets_data.dart';
import 'package:final_subul_project/core/helpers/constants.dart';
import 'package:final_subul_project/core/helpers/extensions.dart';
import 'package:final_subul_project/core/helpers/styles.dart';
import 'package:final_subul_project/core/routing/routes.dart';
import 'package:final_subul_project/core/theming/app_colors.dart';

class CustomTrackShipmentItem extends StatelessWidget {
  const CustomTrackShipmentItem({
    super.key,
    required this.shipmentInProcessEntity,
  });
  final ShipmentInProcessEntity shipmentInProcessEntity;
 

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      width: 290.w,
      child: Row(
        children: [
          Container(
            width: size.width / 1.5,
            height: size.height / 11,
            decoration: BoxDecoration(
              color: AppColors.lightGray2,
              borderRadius: BorderRadius.circular(cornerRadius),
            ),
            child: Row(
              children: [
                SizedBox(width: size.width / 45),
                Row(
                  children: [
                    SvgPicture.asset(AssetsData.money, width: 8.w),
                    SizedBox(width: size.width / 70),
                    Tooltip(
                      message: 'نوع الشحنة',
                      child: Text(
                        shipmentInProcessEntity.type ,
                        style: Styles.textStyle5Sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: size.width / 20),
                Tooltip(
                  message: 'حالة الشحنة',
                  child: Container(
                    width: 30.w,
                    height: 35.h,
                    decoration: BoxDecoration(
                      color:  AppColors.green,
                      borderRadius: BorderRadius.circular(cornerRadius),
                    ),
                    child: Center(
                      child: Text(
                        shipmentInProcessEntity.status ,
                        style: Styles.textStyle4Sp,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: size.width / 10),
                Tooltip(
                  message: 'عدد الطرود',
                  child: Text(
                    shipmentInProcessEntity.declaredParcelsCount.toString(),
                    overflow: TextOverflow.visible,
                    style: Styles.textStyle5Sp,
                  ),
                ),
                SizedBox(width: size.width / 10),
                Flexible(
                  child: Tooltip(
                    message: 'اسم الزبون',
                    child: Text(
                      shipmentInProcessEntity.customerName,
                      style: Styles.textStyle5Sp,
                      softWrap: true,
                    ),
                  ),
                ),
                SizedBox(width: size.width / 40),
                Flexible(
                  child: Tooltip(
                    message: shipmentInProcessEntity.trackingNumber,
                    child: Text(
                      shipmentInProcessEntity.trackingNumber,
                      softWrap: true,
                      style: Styles.textStyle5Sp,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: size.width / 50),

          TextButton(
            onPressed: () {
              context.pushNamed(
                Routes.showParcelsOfSpecificShipment,
                arguments: {
                  "shipment_id": shipmentInProcessEntity.id,
                  "number_of_parcels": shipmentInProcessEntity.declaredParcelsCount,
                },
              );
            },
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(AppColors.goldenYellow),
            ),
            child: Text(
              'عرض الطرود',
              style: Styles.textStyle4Sp.copyWith(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
