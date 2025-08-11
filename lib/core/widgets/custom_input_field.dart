import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:final_subul_project/core/helpers/styles.dart';
import 'package:final_subul_project/core/theming/app_colors.dart';

class CustomInputField extends StatelessWidget {
  const CustomInputField({
    super.key,
    required this.hintText,
    this.icon,
    required this.svgPicture,
    required this.controller,
    this.keyboardType,
    this.validator,
  });

  final String hintText;
  final Icon? icon;
  final SvgPicture svgPicture;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140.w,
      height: 50.h,
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      decoration: BoxDecoration(
        color: AppColors.goldenYellow,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.deepGray, width: 1),
      ),
      child: Row(
        children: [
          svgPicture,
          SizedBox(width: 8.w),
          Expanded(
            child: TextFormField(
              controller: controller,
              keyboardType: keyboardType,
              style: Styles.textStyle3Sp,
              textAlign: TextAlign.right,
              validator: validator,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: Styles.textStyle3Sp.copyWith(
                  color: AppColors.black.withAlpha(100),
                ),
                border: InputBorder.none,
                isCollapsed: true,
                contentPadding: EdgeInsets.symmetric(vertical: 12.h),
              ),
            ),
          ),
          icon ?? const SizedBox(),
        ],
      ),
    );
  }
}
