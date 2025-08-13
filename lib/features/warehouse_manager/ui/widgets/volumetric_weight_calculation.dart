import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:final_subul_project/core/helpers/assets_data.dart';
import 'package:final_subul_project/core/helpers/constants.dart';
import 'package:final_subul_project/core/helpers/styles.dart';
import 'package:final_subul_project/core/theming/app_colors.dart';
import 'package:final_subul_project/core/widgets/custom_ok_button.dart';
import 'package:final_subul_project/features/warehouse_manager/ui/widgets/lableled_remove_add_shipment_widget.dart';

class VolumetricWeightCalculation extends StatefulWidget {
  const VolumetricWeightCalculation({super.key});

  @override
  State<VolumetricWeightCalculation> createState() =>
      _VolumetricWeightCalculationState();
}

class _VolumetricWeightCalculationState
    extends State<VolumetricWeightCalculation> {
  int actualWeight = 0;
  // int specialActualWeight = 0;
  // int normalActualWeight = 0;
  // int specialDimensionalWeight = 0;
  // int normalDimensionalWeight = 0;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: 130.w,
                  height: 800.h,
                  padding: EdgeInsets.symmetric(vertical: 25.h),
                  decoration: BoxDecoration(
                    color: AppColors.lightGray2,
                    borderRadius: BorderRadius.circular(cornerRadius),
                    border: Border.all(width: 1, color: AppColors.goldenYellow),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Text(
                                'حساب الوزن الحجمي للشحنة',
                                style: Styles.textStyle5Sp,
                                overflow: TextOverflow.clip,
                                textDirection: TextDirection.rtl,
                              ),
                            ),
                            Flexible(child: Image.asset(AssetsData.image15)),
                          ],
                        ),
                        SizedBox(height: size.height / 30),
                        LableledRemoveAddShipmentWidget(
                          label: 'الوزن الفعلي',
                          onChanged: (value) => actualWeight = value,
                        ),
                        // SizedBox(height: size.height / 30),
                        // LableledRemoveAddShipmentWidget(
                        //   label: 'الفعلي الخاص',
                        //   onChanged: (value) => specialActualWeight = value,
                        // ),
                        // SizedBox(height: size.height / 30),
                        // LableledRemoveAddShipmentWidget(
                        //   label: 'الفعلي العادي',
                        //   onChanged: (value) => normalActualWeight = value,
                        // ),
                        // SizedBox(height: size.height / 30),
                        // LableledRemoveAddShipmentWidget(
                        //   label: 'الحجمي الخاص',
                        //   onChanged:
                        //       (value) => specialDimensionalWeight = value,
                        // ),
                        // SizedBox(height: size.height / 30),
                        // LableledRemoveAddShipmentWidget(
                        //   label: 'الحجمي العادي',
                        //   onChanged: (value) => normalDimensionalWeight = value,
                        // ),
                        // SizedBox(height: size.height / 30),
                        // Container(
                        //   width: 70.w,
                        //   height: 45.h,
                        //   padding: EdgeInsets.symmetric(horizontal: 3.w),
                        //   decoration: BoxDecoration(
                        //     color: AppColors.white,
                        //     borderRadius: BorderRadius.circular(10),
                        //     boxShadow: [
                        //       BoxShadow(
                        //         color: Colors.grey,
                        //         blurRadius: 3,
                        //         // spreadRadius: 1,
                        //         offset: const Offset(0, 4),
                        //       ),
                        //     ],
                        //   ),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       Flexible(
                        //         child: Text(
                        //           '1',
                        //           style: Styles.textStyle4Sp.copyWith(
                        //             color: AppColors.gunmetal,
                        //           ),
                        //         ),
                        //       ),
                        //       Flexible(
                        //         child: Text(
                        //           'إجمالي وزن الشحنة',
                        //           style: Styles.textStyle4Sp.copyWith(
                        //             color: AppColors.gunmetal,
                        //           ),
                        //           maxLines: 1,
                        //           overflow: TextOverflow.clip,
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        SizedBox(height: size.height / 10),
                        CustomOkButton(
                          onTap: () {
                            Navigator.pop(context, {
                              'actualWeight': actualWeight,
                              // 'specialActualWeight': specialActualWeight,
                              // 'normalActualWeight': normalActualWeight,
                              // 'specialDimensionalWeight':
                              //     specialDimensionalWeight,
                              // 'normalDimensionalWeight':
                              //     normalDimensionalWeight,
                            });
                          },
                          color: AppColors.goldenYellow,
                          label: 'موافق',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
