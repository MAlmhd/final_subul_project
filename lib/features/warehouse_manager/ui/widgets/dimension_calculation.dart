import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:final_subul_project/core/helpers/assets_data.dart';
import 'package:final_subul_project/core/helpers/constants.dart';
import 'package:final_subul_project/core/helpers/styles.dart';
import 'package:final_subul_project/core/theming/app_colors.dart';
import 'package:final_subul_project/core/widgets/custom_ok_button.dart';
import 'package:final_subul_project/features/warehouse_manager/ui/widgets/lableled_remove_add_shipment_widget.dart';

class DimensionCalculation extends StatefulWidget {
  const DimensionCalculation({super.key});

  @override
  State<DimensionCalculation> createState() => _DimensionCalculationState();
}

class _DimensionCalculationState extends State<DimensionCalculation> {
  int height = 0;
  int width = 0;
  int length = 0;
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
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                  child: Container(),
                ),
                Container(
                  width: 130.w,
                  height: 700.h,
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
                                'حساب الأبعاد',
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
                          label: 'الارتفاع',
                          onChanged: (value) => height = value,
                        ),
                        SizedBox(height: size.height / 30),
                        LableledRemoveAddShipmentWidget(
                          label: 'الطول',
                          onChanged: (value) => length = value,
                        ),
                        SizedBox(height: size.height / 30),
                        LableledRemoveAddShipmentWidget(
                          label: 'العرض',
                          onChanged: (value) => width = value,
                        ),
                        SizedBox(height: size.height / 10),

                        // Container(
                        //   width: 90.w,
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
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     children: [
                        //       Flexible(
                        //         child: Text(
                        //           'الوزن الحجمي',
                        //           style: Styles.textStyle4Sp,
                        //         ),
                        //       ),
                        //       SizedBox(width: size.width /120,),
                        //       Flexible(
                        //         child: SvgPicture.asset(AssetsData.outlinePurpleBox),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // SizedBox(height: size.height / 30),
                        // Container(
                        //   width: 90.w,
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
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     children: [
                        //       Flexible(
                        //         child: Text(
                        //           'الوزن النهائي المحسوب',
                        //           style: Styles.textStyle4Sp,
                        //         ),
                        //       ),
                        //       SizedBox(width: size.width /120,),
                        //       Flexible(
                        //         child: SvgPicture.asset(AssetsData.outlinePurpleBox),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        SizedBox(height: size.height / 10),
                        CustomOkButton(
                          onTap: () {
                            Navigator.pop(context, {
                              'height': height,
                              'length': length,
                              'width': width,
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
