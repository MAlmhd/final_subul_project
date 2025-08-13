import 'package:final_subul_project/core/helpers/extensions.dart';
import 'package:final_subul_project/core/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:final_subul_project/core/helpers/assets_data.dart';
import 'package:final_subul_project/core/helpers/constants.dart';
import 'package:final_subul_project/core/helpers/styles.dart';
import 'package:final_subul_project/core/theming/app_colors.dart';
import 'package:final_subul_project/core/utils/functions/show_snack_bar.dart';
import 'package:final_subul_project/core/widgets/custom_progress_indicator.dart';
import 'package:final_subul_project/features/get_shipment_in_process/presentation/manager/get_shipment_details/get_shipment_details_cubit.dart';
import 'package:final_subul_project/features/warehouse_manager/ui/widgets/custom_labeled_border.dart';

class ShipmentReceipt extends StatelessWidget {
  const ShipmentReceipt({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        
      ),
      body: Center(
        child: SingleChildScrollView(
          child: BlocConsumer<GetShipmentDetailsCubit, GetShipmentDetailsState>(
            listener: (BuildContext context, GetShipmentDetailsState state) {
              if (state is GetShipmentDetailsFailure) {
                showSnackBar(context, state.message, Colors.red);
              }
            },
            builder: (context, state) {
              if (state is GetShipmentDetailsSuccess) {
                return Container(
                  width: 300.w,
                  decoration: BoxDecoration(
                    color: AppColors.lightGray2,
                    borderRadius: BorderRadius.circular(cornerRadius),
                    border: Border.all(width: 1, color: AppColors.goldenYellow),
                  ),
                  child: Column(
                    children: [
                      Image.asset(AssetsData.subulLogo),
                      SizedBox(height: size.height / 60),
                      CustomLabeledBorder(
                        label: 'تاريخ الشحنة:${state.entity.shipmentDate}',
                      ),
                      SizedBox(height: size.height / 60),
                      CustomLabeledBorder(
                        label: 'اسم العميل:${state.entity.customerName}',
                      ),
                      SizedBox(height: size.height / 60),
                      CustomLabeledBorder(
                        label: 'رقم العميل:${state.entity.customerPhone}',
                      ),
                      SizedBox(height: size.height / 60),
                      CustomLabeledBorder(
                        label: 'رقم الاستلام:${state.entity.receiptNumber}',
                      ),
                      SizedBox(height: size.height / 60),
                      CustomLabeledBorder(
                        label:
                            'الرقم الخاص بالشحنة:${state.entity.shipmentCode}',
                      ),
                      SizedBox(height: size.height / 30),
                      Container(
                        width: 80.w,
                        height: 148.h,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          border: Border.all(
                            color: AppColors.goldenYellow,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Table(
                          border: TableBorder(
                            horizontalInside: BorderSide(
                              color: AppColors.goldenYellow,
                              width: 1,
                            ),

                            verticalInside: BorderSide(
                              color: AppColors.goldenYellow,
                              width: 1,
                            ),
                          ),

                          children: [
                            TableRow(
                              children: [
                                _buildHeaderCell("الملاحظات"),
                                _buildHeaderCell("الوزن"),
                                _buildHeaderCell("الوصف"),
                                _buildHeaderCell("العدد"),
                              ],
                            ),
                            TableRow(
                              children: [
                                _buildCell(state.entity.notes),
                                _buildCell("${state.entity.weight}"),
                                _buildCell(""),
                                _buildCell("${state.entity.parcelsCount}"),
                              ],
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: size.height / 40),
                      Text(
                        'رمز الموظف المستلم:',
                        textAlign: TextAlign.end,

                        style: Styles.textStyle4Sp.copyWith(
                          color: AppColors.black.withValues(alpha: 0.4),
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                    ],
                  ),
                );
              } else if (state is GetShipmentDetailsLoading) {
                return CustomProgressIndicator();
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}

Widget _buildHeaderCell(String text) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(
      text,
      textAlign: TextAlign.center,
      style: Styles.textStyle3Sp.copyWith(
        color: AppColors.black.withValues(alpha: 0.4),
      ),
    ),
  );
}

Widget _buildCell(String text) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: SizedBox(
      height: 100.h,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: Styles.textStyle3Sp.copyWith(
          color: AppColors.black.withValues(alpha: 0.4),
        ),
      ),
    ),
  );
}
