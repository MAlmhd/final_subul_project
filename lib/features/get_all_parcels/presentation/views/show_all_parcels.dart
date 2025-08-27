import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:final_subul_project/core/helpers/constants.dart';
import 'package:final_subul_project/core/helpers/styles.dart';
import 'package:final_subul_project/core/theming/app_colors.dart';
import 'package:final_subul_project/core/utils/functions/show_snack_bar.dart';
import 'package:final_subul_project/core/widgets/custom_progress_indicator.dart';
import 'package:final_subul_project/core/widgets/custom_search_item.dart';
import 'package:final_subul_project/core/widgets/text_logo.dart';
import 'package:final_subul_project/features/get_all_parcels/presentation/manager/get_all_parcels_cubit/get_all_parcels_cubit.dart';
import 'package:final_subul_project/features/get_shipment_in_process/presentation/views/widgets/custom_item_in_show_all_parcels_table.dart';
import 'package:final_subul_project/features/warehouse_manager/ui/widgets/name_of_columns_in_show_all_shipments_table.dart';

class ShowAllParcels extends StatelessWidget {
  const ShowAllParcels({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,

        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.grey, AppColors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 30.h),
                child: SizedBox(
                  width: 600.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 60.w,
                        child: Text(
                          'عرض جميع الطرود',
                          style: Styles.textStyle7Sp.copyWith(
                            color: AppColors.goldenYellow,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.clip,
                        ),
                      ),
                      CustomSearchItem(
                        backgoundColor: AppColors.white,
                        hintText: 'فلترة من خلال',
                        icon: Icon(Icons.tune, color: AppColors.white),
                        textColor: AppColors.black,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: size.height / 120),
              NameOfColumnsInShowAllShipmentsTable(),
              SizedBox(height: size.height / 30),
              SizedBox(
                height: 430.h,
                width: 600.w,
                child: BlocConsumer<GetAllParcelsCubit, GetAllParcelsState>(
                  listener: (context, state) {
                    if (state is GetAllParcelsFailure) {
                      showToastMsg(context, state.message);
                    }
                  },
                  builder: (context, state) {
                    if (state is GetAllParcelsLoading) {
                      return const CustomProgressIndicator();
                    } else if (state is GetAllParcelsSuccess) {
                      final parcels = state.parcels;
                      if (parcels.isEmpty) {
                        return Center(child: Text("لا توجد طرود حالياً."));
                      }
                      return ListView.builder(
                        itemCount: parcels.length,
                        itemBuilder:
                            (context, index) => Padding(
                              padding: EdgeInsets.only(bottom: 25.h),
                              child: CustomItemInShowAllShipmentsTable(
                                id: parcels[index].id,
                                shipmentId: parcels[index].shipmentId,
                                actualWeight: parcels[index].actualWeight,
                               
                                length: parcels[index].length,
                                width: parcels[index].width,
                                height: parcels[index].height,
                               
                                customerId: parcels[index].customerId,
                                firstName: parcels[index].firstName,
                                lastName: parcels[index].lastName,
                              ),
                            ),
                      );
                    } else {
                      return Container(); // حالة مبدئية غير معرفة
                    }
                  },
                ),
              ),
              SizedBox(height: size.height / 50),
              Padding(
                padding: EdgeInsets.only(right: 15.w),
                child: SizedBox(
                  width: 40.w,
                  child: Text(
                    ':القيمة الإجمالية',
                    textAlign: TextAlign.center,
                    style: Styles.textStyle5Sp,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),

                child: SizedBox(
                  width: 125.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 40.w,
                        height: 55.h,
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 10.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.goldenYellow,
                          borderRadius: BorderRadius.circular(cornerRadius),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('إنشاء طرد', style: Styles.textStyle3Sp),
                            Icon(Icons.add, color: AppColors.white),
                          ],
                        ),
                      ),
                      Container(
                        width: 80.w,
                        height: 55.h,
                        decoration: BoxDecoration(
                          color: AppColors.goldenYellow,
                          borderRadius: BorderRadius.circular(cornerRadius),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
