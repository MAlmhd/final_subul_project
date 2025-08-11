import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:final_subul_project/core/helpers/styles.dart';

class NameOfColumnsInShowAllShipmentsTable extends StatelessWidget {
  const NameOfColumnsInShowAllShipmentsTable({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 600.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          SizedBox(
            width: 60.w,
            child: Text(
              'الوزن الحجمي المحسوب',
              textAlign: TextAlign.center,
              style: Styles.textStyle6Sp,
              maxLines: 1,
              overflow: TextOverflow.clip,
            ),
          ),
          SizedBox(
            width: 20.w,
            child: Text(
              'الوزن النهائي المحسوب',
              textAlign: TextAlign.center,
              style: Styles.textStyle6Sp,
              maxLines: 1,
              overflow: TextOverflow.clip,
            ),
          ),
          SizedBox(
            width: 20.w,
            child: Text(
              'العرض',
              textAlign: TextAlign.center,
              style: Styles.textStyle6Sp,
              maxLines: 1,
              overflow: TextOverflow.clip,
            ),
          ),
          SizedBox(
            width: 20.w,
            child: Text(
              'الطول',
              textAlign: TextAlign.center,
              style: Styles.textStyle6Sp,
              maxLines: 1,
              overflow: TextOverflow.clip,
            ),
          ),
          SizedBox(
            width: 40.w,
            child: Text(
              'الارتفاع',
              textAlign: TextAlign.center,
              style: Styles.textStyle6Sp,
              maxLines: 1,
              overflow: TextOverflow.clip,
            ),
          ),
          SizedBox(
            width: 40.w,
            child: Text(
              'الوزن الحجمي العادي',
              textAlign: TextAlign.center,
              style: Styles.textStyle6Sp,
              maxLines: 1,
              overflow: TextOverflow.clip,
            ),
          ),
          SizedBox(
            width: 40.w,
            child: Text(
              'الوزن الحجمي الخاص',
              textAlign: TextAlign.center,
              style: Styles.textStyle6Sp,
              maxLines: 1,
              overflow: TextOverflow.clip,
            ),
          ),
          SizedBox(
            width: 40.w,
            child: Text(
              'الوزن الفعلي العادي',
              textAlign: TextAlign.center,
              style: Styles.textStyle6Sp,
              maxLines: 1,
              overflow: TextOverflow.clip,
            ),
          ),
          SizedBox(
            width: 40.w,
            child: Text(
              ' الوزن الفعلي الخاص',
              textAlign: TextAlign.center,
              style: Styles.textStyle6Sp,
              maxLines: 1,
              overflow: TextOverflow.clip,
            ),
          ),
          SizedBox(
            width: 40.w,
            child: Text(
              'الوزن الفعلي',
              textAlign: TextAlign.center,
              style: Styles.textStyle6Sp,
              maxLines: 1,
              overflow: TextOverflow.clip,
            ),
          ),
          SizedBox(
            width: 40.w,
            child: Text(
              'العميل',
              textAlign: TextAlign.center,
              style: Styles.textStyle6Sp,
              maxLines: 1,
              overflow: TextOverflow.clip,
            ),
          ),
        ],
      ),
    );
  }
}
