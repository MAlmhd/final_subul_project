import 'package:final_subul_project/core/helpers/create_parcels_request.dart';
import 'package:final_subul_project/features/get_shipment_in_process/presentation/views/widgets/item_count_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:final_subul_project/core/helpers/assets_data.dart';

import 'package:final_subul_project/core/widgets/custom_ok_button.dart';
import 'package:final_subul_project/core/widgets/custom_progress_indicator.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/entities/allowed_content_entity/allowed_content_entity.dart';
import 'package:final_subul_project/features/get_shipment_in_process/presentation/manager/get_allowed_content_cubit/get_allowed_content_cubit.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/theming/app_colors.dart';
import '../../../../warehouse_manager/ui/widgets/labeled_icon_text_field.dart';

class CreateParcelItemScreen extends StatefulWidget {
  final int id;
  final num length;
  final num width;
  final num height;
  final num actualWeight;
  final String brandType;
  final bool isFragile;
  final bool needsRepacking;
  final String notes;
  final XFile scaledPhoto;

  const CreateParcelItemScreen({
    super.key,
    required this.id,
    required this.length,
    required this.width,
    required this.height,
    required this.brandType,
    required this.isFragile,
    required this.needsRepacking,
    required this.notes,
    required this.actualWeight,
    required this.scaledPhoto,
  });

  @override
  State<CreateParcelItemScreen> createState() => _CreateParcelItemScreenState();
}

class _CreateParcelItemScreenState extends State<CreateParcelItemScreen> {
  // أرقام ونصوص العناصر
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController valuePerItemController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  // حقل الأنواع مع الاقتراحات
  final TextEditingController _typeCtrl = TextEditingController();
  final FocusNode _typeFocus = FocusNode();

  // النوع المختار فعليًا من القائمة
  String? selectedType;
  AllowedContentEntity? selctedAllowedContentEntity;

  // العناصر التي ستُرسل مع الطرد
  final List<ParcelItemRequest> items = [];

  @override
  void dispose() {
    quantityController.dispose();
    valuePerItemController.dispose();
    descriptionController.dispose();
    _typeCtrl.dispose();
    _typeFocus.dispose();
    super.dispose();
  }

  final GlobalKey _typeFieldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGray,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /// =================== حقل الأنواع مع Autocomplete ===================
                BlocBuilder<GetAllowedContentCubit, GetAllowedContentState>(
                  builder: (context, state) {
                    if (state is GetAllowedContentLoading) {
                      return const CustomProgressIndicator();
                    }
                    if (state is! GetAllowedContentSuccess) {
                      return const SizedBox.shrink();
                    }

                    final all = state.contents; // List<AllowedContentEntity>

                    return RawAutocomplete<AllowedContentEntity>(
                      optionsBuilder: (TextEditingValue text) {
                        final q = text.text.trim().toLowerCase();
                        if (q.isEmpty) {
                          // عرض الكل عند التركيز (اختياري)
                          return all;
                        }
                        return all.where(
                          (e) => e.content.toLowerCase().contains(q),
                        );
                      },
                      displayStringForOption: (o) => o.content,
                      onSelected: (opt) {
                        setState(() {
                          selctedAllowedContentEntity = opt;
                          selectedType = opt.content;
                          _typeCtrl.text = opt.content;
                        });
                      },
                      fieldViewBuilder: (
                        context,
                        textController,
                        focusNode,
                        onSubmit,
                      ) {
                        // إبقاء القيمة متزامنة
                        _typeCtrl.value = textController.value;

                        return Container(
                          key: _typeFieldKey,
                          width: 110.w,
                          height: 50.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16.r),
                            border: Border.all(
                              color: AppColors.goldenYellow,
                              width: 2,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 14.w),
                          alignment: Alignment.center,
                          child: Row(
                            children: [
                              SvgPicture.asset(AssetsData.bulb, height: 20.h),
                              SizedBox(width: 10.w),
                              Expanded(
                                child: TextField(
                                  controller: textController,
                                  focusNode: focusNode,
                                  textAlign: TextAlign.right,
                                  textDirection: TextDirection.rtl,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'الأنواع المسموحة',
                                  ),
                                  onChanged: (_) {
                                    // أي تغيير يدوي يلغي التحديد السابق
                                    selctedAllowedContentEntity = null;
                                    selectedType = null;
                                  },
                                  onSubmitted: (_) => onSubmit(),
                                ),
                              ),
                              const Icon(Icons.keyboard_arrow_down),
                            ],
                          ),
                        );
                      },
                      optionsViewBuilder: (context, onSelected, options) {
                        final renderBox =
                            _typeFieldKey.currentContext?.findRenderObject()
                                as RenderBox?;
                        final double fieldWidth =
                            renderBox?.size.width ?? 300; // fallback
                        final opts = options.toList();
                        return Align(
                          alignment: AlignmentDirectional.topStart,
                          child: Material(
                            elevation: 4,
                            borderRadius: BorderRadius.circular(12),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: fieldWidth,
                                // ارتفاع مناسب مع سكرول
                                maxHeight: 220,
                              ),
                              child:
                                  opts.isEmpty
                                      ? Container(
                                        padding: EdgeInsets.all(12.w),
                                        alignment: Alignment.center,
                                        child: Text(
                                          'لا توجد نتائج',
                                          style: TextStyle(
                                            color: Colors.grey[700],
                                          ),
                                        ),
                                      )
                                      : ListView.separated(
                                        padding: EdgeInsets.zero,
                                        itemCount: opts.length,
                                        separatorBuilder:
                                            (_, __) => const Divider(height: 1),
                                        itemBuilder: (context, i) {
                                          final o = opts[i];
                                          return ListTile(
                                            dense: true,
                                            title: Text(
                                              o.content,
                                              textAlign: TextAlign.right,
                                              textDirection: TextDirection.rtl,
                                            ),
                                            onTap: () => onSelected(o),
                                          );
                                        },
                                      ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),

                SizedBox(height: 16.h),

                /// =================== بقية الحقول ===================
                LabeledIconTextField(
                  svgPicture: SvgPicture.asset(AssetsData.aLetter),
                  hintText: 'الكمية',
                  controller: quantityController,
                ),
                SizedBox(height: 16.h),
                LabeledIconTextField(
                  svgPicture: SvgPicture.asset(AssetsData.aLetter),
                  hintText: 'قيمة كل عنصر',
                  controller: valuePerItemController,
                ),
                SizedBox(height: 16.h),
                LabeledIconTextField(
                  svgPicture: SvgPicture.asset(AssetsData.aLetter),
                  hintText: 'الوصف',
                  controller: descriptionController,
                ),

                SizedBox(height: 24.h),
                ItemCountBadge(count: items.length),
                SizedBox(height: 16.h),

                /// =================== زر إضافة عنصر ===================
                CustomOkButton(
                  onTap: () {
                    // تحقق أن النوع مختار من المقترحات (selctedAllowedContentEntity != null)
                    if (selctedAllowedContentEntity == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('اختر نوعًا من المقترحات'),
                        ),
                      );
                      return;
                    }

                    final q = int.tryParse(quantityController.text) ?? 0;
                    final v = int.tryParse(valuePerItemController.text) ?? 0;
                    final desc = descriptionController.text.trim();

                    if (q <= 0 || v < 0 || desc.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('أكمل الحقول بشكل صحيح')),
                      );
                      return;
                    }

                    final parcel = ParcelItemRequest(
                      itemType: selctedAllowedContentEntity!.content,
                      quantity: q,
                      valuePerItem: v,
                      description: desc,
                    );

                    setState(() {
                      items.add(parcel);
                      // اختياري: تفريغ الحقول بعد الإضافة
                      // _typeCtrl.clear();
                      // selctedAllowedContentEntity = null;
                      // selectedType = null;
                      // quantityController.clear();
                      // valuePerItemController.clear();
                      // descriptionController.clear();
                    });
                  },
                  color: AppColors.goldenYellow,
                  label: 'إضافة عنصر',
                ),

                SizedBox(height: 16.h),

                /// =================== زر حفظ ===================
                CustomOkButton(
                  onTap: () {
                    if (items.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('أضف عنصرًا واحدًا على الأقل'),
                        ),
                      );
                      return;
                    }

                    final parcelRequest = ParcelRequest(
                      actualWeight: widget.actualWeight,
                      length: widget.length,
                      width: widget.width,
                      height: widget.height,
                      isFragile: widget.isFragile,
                      needsRepacking: widget.needsRepacking,
                      items: items,
                      scaledPhoto: widget.scaledPhoto,
                      brandType: widget.brandType,
                      notes: widget.notes,
                    );

                    Navigator.pop(
                      context,
                      parcelRequest,
                    ); // ارجاع النتيجة للشاشة الأولى
                  },
                  color: AppColors.deepPurple,
                  label: "حفظ",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
