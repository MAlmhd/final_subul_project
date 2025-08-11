import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:final_subul_project/core/theming/app_colors.dart';
import 'package:final_subul_project/core/helpers/styles.dart';

class GenericDropdownField<T> extends StatelessWidget {
  final List<T> items;
  final T? selectedItem;
  final void Function(T?) onChanged;
  final String Function(T) itemAsString;
  final String hintText;
  final SvgPicture svgIcon;
  final Icon? trailingIcon;
  final String? Function(T?)? validator;

  const GenericDropdownField({
    super.key,
    required this.items,
    required this.selectedItem,
    required this.onChanged,
    required this.itemAsString,
    required this.hintText,
    required this.svgIcon,
    this.trailingIcon,
    this.validator,
  });

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
      child: Center(
        child: DropdownButtonFormField<T>(
          isExpanded: true,
          value: selectedItem,
          validator: validator,
          icon: trailingIcon ?? const Icon(Icons.keyboard_arrow_down_rounded),
          decoration: const InputDecoration.collapsed(hintText: ''),
          items:
              items.map((item) {
                return DropdownMenuItem<T>(
                  value: item,
                  child: Row(
                    children: [
                      svgIcon,
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Text(
                          itemAsString(item),
                          style: Styles.textStyle3Sp,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
          onChanged: onChanged,
          hint: Row(
            children: [
              svgIcon,
              SizedBox(width: 8.w),
              Text(
                hintText,
                style: Styles.textStyle3Sp.copyWith(
                  color: AppColors.black.withAlpha(100),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
