import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:final_subul_project/core/theming/app_colors.dart';
import 'package:final_subul_project/core/helpers/styles.dart';

class MultiSelectField<T> extends StatelessWidget {
  const MultiSelectField({
    super.key,
    required this.hintText,
    required this.svgIcon,
    required this.selectedItemsText,
    required this.onTap,
    this.errorText,
  });

  final String hintText;
  final SvgPicture svgIcon;
  final String selectedItemsText; // النص المعرُوض داخل الحقل (أسماء مختارة مفصولة بفواصل)
  final VoidCallback onTap;
  final String? errorText; // لإظهار رسالة التحقق أسفل الحقل إن لزم

  @override
  Widget build(BuildContext context) {
    final hasValue = selectedItemsText.trim().isNotEmpty;

    // نفس ستايل حقولك (golden box + border + radius + height)
    final box = Container(
      width: 140.w,
      height: 50.h,
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        color: AppColors.goldenYellow,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.deepGray, width: 1),
      ),
      child: Row(
        children: [
          svgIcon,
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              hasValue ? selectedItemsText : hintText,
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis,
              style: Styles.textStyle3Sp.copyWith(
                color: hasValue
                    ? AppColors.black
                    : AppColors.black.withAlpha(100),
              ),
              maxLines: 1,
            ),
          ),
          Icon(Icons.keyboard_arrow_down, color: AppColors.deepPurple),
        ],
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          child: box,
        ),
       
      ],
    );
  }
}

Future<List<T>?> showMultiSelectDialog<T>({
  required BuildContext context,
  required List<T> items,
  required bool Function(T a, T b) equals,
  required String Function(T) labelOf,
  required List<T> initiallySelected,
  String title = 'اختر العناصر',
}) {
  final selected = List<T>.from(initiallySelected);
  return showDialog<List<T>>(
    context: context,
    builder: (ctx) {
      return AlertDialog(
        title: Text(title, textAlign: TextAlign.right),
        content: StatefulBuilder(
          builder: (ctx, setSt) {
            return SizedBox(                 // ✅ حددنا حجمًا واضحًا
              width: 480,                    // استعمل .w إذا أردت
              height: 360,                   // استعمل .h إذا أردت
              child: ListView.builder(
                // لا تستخدم shrinkWrap هنا
                itemCount: items.length,
                itemBuilder: (_, i) {
                  final item = items[i];
                  final isSel = selected.any((e) => equals(e, item));
                  return CheckboxListTile(
                    value: isSel,
                    onChanged: (v) {
                      setSt(() {
                        if (v == true) {
                          selected.add(item);
                        } else {
                          selected.removeWhere((e) => equals(e, item));
                        }
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                    title: Text(labelOf(item), textAlign: TextAlign.right),
                  );
                },
              ),
            );
          },
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, null), child: const Text('إلغاء')),
          FilledButton(onPressed: () => Navigator.pop(ctx, selected), child: const Text('تم')),
        ],
      );
    },
  );
}
