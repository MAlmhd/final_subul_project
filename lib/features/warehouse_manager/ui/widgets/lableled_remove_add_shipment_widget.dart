import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:final_subul_project/core/helpers/assets_data.dart';
import 'package:final_subul_project/core/helpers/constants.dart';
import 'package:final_subul_project/core/helpers/styles.dart';
import 'package:final_subul_project/core/theming/app_colors.dart';

class LableledRemoveAddShipmentWidget extends StatefulWidget {
  const LableledRemoveAddShipmentWidget({
    super.key,
    required this.label,
    required this.onChanged,
  });
  final String label;
  final ValueChanged<int> onChanged;

  @override
  State<LableledRemoveAddShipmentWidget> createState() =>
      _LableledRemoveAddShipmentWidgetState();
}

class _LableledRemoveAddShipmentWidgetState
    extends State<LableledRemoveAddShipmentWidget> {
  int number = 0;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Text(
                widget.label,
                style: Styles.textStyle4Sp,
                overflow: TextOverflow.clip,
                textDirection: TextDirection.rtl,
              ),
            ),
            SizedBox(width: size.width / 100),
            Flexible(child: SvgPicture.asset(AssetsData.outlinePurpleBox)),
          ],
        ),
        SizedBox(height: size.height / 50),
        Container(
          width: 55.w,
          height: 45.h,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(cornerRadius),
            border: Border.all(width: 2, color: AppColors.deepPurple),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      if (number == 0) return;
                      setState(() {
                        number--;
                      });
                      widget.onChanged(number);
                    },
                    child: CircleAvatar(
                      maxRadius: 4.w,
                      backgroundColor: AppColors.deepPurple,
                      child: Icon(Icons.remove, color: AppColors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(width: size.width / 100),
              Flexible(
                child: Text(
                  "$number",
                  style: Styles.textStyle5Sp.copyWith(
                    color: AppColors.deepPurple,
                  ),
                ),
              ),
              SizedBox(width: size.width / 100),
              Flexible(
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        number++;
                      });
                      widget.onChanged(number);
                    },
                    child: CircleAvatar(
                      maxRadius: 4.w,
                      backgroundColor: AppColors.deepPurple,
                      child: Icon(Icons.add, color: AppColors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
