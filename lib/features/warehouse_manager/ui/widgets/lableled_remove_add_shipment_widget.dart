import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  late final TextEditingController _controller;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: '0');
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _syncAndNotify(int value) {
    if (value < 0) value = 0;
    number = value;
    // لا داعي لـ setState لأن النص يُدار من خلال الـ controller
    _controller.text = number.toString();
    _controller.selection = TextSelection.fromPosition(
      TextPosition(offset: _controller.text.length),
    );
    widget.onChanged(number);
  }

  void _applyFromField() {
    final text = _controller.text.trim();
    final parsed = int.tryParse(text);
    _syncAndNotify(parsed ?? 0);
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        // العنوان + الأيقونة
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

        // نفس الشكل تمامًا: نفس Container والحدود — لكن بدون أزرار
        Container(
          width: 55.w,
          height: 45.h,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(cornerRadius),
            border: Border.all(width: 2, color: AppColors.deepPurple),
          ),
          alignment: Alignment.center,
          child: SizedBox(
            width: 28.w, // مساحة كتابة مريحة داخل الصندوق
            child: TextFormField(
              focusNode: _focusNode,
              controller: _controller,
              textAlign: TextAlign.center,
              style: Styles.textStyle5Sp.copyWith(color: AppColors.deepPurple),
              keyboardType: const TextInputType.numberWithOptions(
                signed: false, decimal: false,
              ),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: const InputDecoration(
                isDense: true,
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                hintText: '0',
              ),
              onChanged: (val) {
                // حدث فوري (اختياري): مرّر القيمة للوالد أثناء الكتابة
                final parsed = int.tryParse(val);
                widget.onChanged(parsed ?? 0);
              },
              onEditingComplete: _applyFromField,
              onFieldSubmitted: (_) => _applyFromField(),
            ),
          ),
        ),
      ],
    );
  }
}
