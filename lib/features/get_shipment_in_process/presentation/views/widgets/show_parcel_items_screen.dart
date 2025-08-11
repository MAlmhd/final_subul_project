import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:final_subul_project/core/widgets/custom_progress_indicator.dart';
import 'package:final_subul_project/features/get_shipment_in_process/presentation/manager/get_parcel_items_cubit/get_parcel_items_cubit.dart';

class ShowParcelItemsScreen extends StatefulWidget {
  final int id;
  const ShowParcelItemsScreen({super.key, required this.id});

  @override
  State<ShowParcelItemsScreen> createState() => _ShowParcelItemsScreenState();
}

class _ShowParcelItemsScreenState extends State<ShowParcelItemsScreen> {
  @override
  void initState() {
    context.read<GetParcelItemsCubit>().getParcelItems(id: widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Padding(
        padding: EdgeInsets.all(16.0.w),
        child: Column(
          children: [
            // ✅ Header
            Container(
              padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 12.w),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.indigo.shade400, Colors.indigo.shade700],
                ),
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'النوع',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 5.sp,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        'الكمية',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 5.sp,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'القيمة',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 5.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 14.h),
            // ✅ List items
            BlocBuilder<GetParcelItemsCubit, GetParcelItemsState>(
              builder: (context, state) {
                if (state is GetParcelItemsSuccess) {
                  return Expanded(
                    child: ListView.separated(
                      itemCount: state.items.length,
                      separatorBuilder: (_, __) => SizedBox(height: 10.h),
                      itemBuilder: (context, index) {
                        return AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          padding: EdgeInsets.symmetric(
                            vertical: 14.h,
                            horizontal: 12.w,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.9),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4,
                                offset: Offset(1, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Icon(Icons.category, color: Colors.indigo),
                                    SizedBox(width: 6.w),
                                    Flexible(
                                      child: Text(
                                        state.items[index].itemType,
                                        style: TextStyle(
                                          fontSize: 5.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    state.items[index].quantity.toString(),
                                    style: TextStyle(fontSize: 5.sp),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        state.items[index].valuePerItem
                                            .toString(),
                                        style: TextStyle(fontSize: 5.sp),
                                      ),
                                      SizedBox(width: 4.w),
                                      Icon(
                                        Icons.attach_money,
                                        size: 5.sp,
                                        color: Colors.green,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                } else if (state is GetParcelItemsLoading) {
                  return CustomProgressIndicator();
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
