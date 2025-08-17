
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TitlesOfDeliveredShipments extends StatelessWidget {
  const TitlesOfDeliveredShipments({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      color: Colors.grey[200],
      child: Row(
        children: const [
          Expanded(flex: 3, child: Text('رقم التتبع', style: TextStyle(fontWeight: FontWeight.bold))),
          Expanded(flex: 2, child: Text('اسم الزبون', style: TextStyle(fontWeight: FontWeight.bold))),
          Expanded(flex: 2, child: Text('كود الزبوم', style: TextStyle(fontWeight: FontWeight.bold))),
          Expanded(flex: 2, child: Text('تاريخ انشاء الشحنة', style: TextStyle(fontWeight: FontWeight.bold))),
          SizedBox(width: 40), 
        ],
      ),
    );
  }
}
