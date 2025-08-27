
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class TitlesOfShipments extends StatelessWidget {
  const TitlesOfShipments({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality( // لضمان المحاذاة RTL
      textDirection: TextDirection.rtl,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        color: Colors.grey[200],
        child: Row(
          children: const [
            Expanded(flex: 3, child: Text('رقم التتبع', style: TextStyle(fontWeight: FontWeight.bold))),
            Expanded(flex: 2, child: Text('البلد المصدر', style: TextStyle(fontWeight: FontWeight.bold))),
            Expanded(flex: 2, child: Text('البلد الوجهة', style: TextStyle(fontWeight: FontWeight.bold))),
            Expanded(flex: 1, child: Text('عدد الطرود', style: TextStyle(fontWeight: FontWeight.bold))),
            Expanded(flex: 2, child: Text('اسم الزبون', style: TextStyle(fontWeight: FontWeight.bold))), // ← كانت 1
            Expanded(flex: 2, child: Text('حالة الشحنة', style: TextStyle(fontWeight: FontWeight.bold))),
            Expanded(flex: 2, child: Text('نوع الشحنة', style: TextStyle(fontWeight: FontWeight.bold))),
          ],
        ),
      ),
    );
  }
}
