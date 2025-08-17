import 'dart:typed_data';
import 'package:final_subul_project/core/helpers/create_parcels_request.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/use_case/create_multiple_parcels_use_case/create_multiple_parcels_use_case.dart';
import 'package:final_subul_project/features/get_shipment_in_process/presentation/manager/create_multiple_parcels_cubit/create_multiple_parcels_cubit.dart';
import 'package:final_subul_project/features/warehouse_manager/ui/widgets/labeled_icon_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:final_subul_project/core/helpers/assets_data.dart';
import 'package:final_subul_project/core/helpers/constants.dart';
import 'package:final_subul_project/core/helpers/extensions.dart';
import 'package:final_subul_project/core/helpers/styles.dart';
import 'package:final_subul_project/core/routing/routes.dart';
import 'package:final_subul_project/core/theming/app_colors.dart';
import 'package:final_subul_project/core/utils/service_locator.dart';
import 'package:final_subul_project/core/widgets/custom_ok_button.dart';
import 'package:final_subul_project/core/widgets/custom_progress_indicator.dart';
import 'package:final_subul_project/core/widgets/custom_switch_label.dart';
import 'package:final_subul_project/features/warehouse_manager/ui/widgets/custom_note.dart';
import 'package:final_subul_project/features/warehouse_manager/ui/widgets/dimension_calculation.dart';
import 'package:final_subul_project/features/warehouse_manager/ui/widgets/volumetric_weight_calculation.dart';

class CreateParcel extends StatefulWidget {
  const CreateParcel({
    super.key,
    required this.shipmentId,
    required this.numberOfParcels, // العدد المطلوب كليًا (Declared)
    required this.numberOfCreatedParcels, // العدد المنشأ مسبقًا (Created)
  });

  final int shipmentId;
  final int numberOfParcels;
  final int numberOfCreatedParcels;

  @override
  State<CreateParcel> createState() => _CreateParcelState();
}

class _CreateParcelState extends State<CreateParcel> {
  XFile? pickedImage;
  Uint8List? imageBytes;

  void _resetDraft() {
    // النصوص
    brandController.clear();
    notesController.clear();

    // السويتشات
    isFragile = true;
    isNeedsRepacking = true;

    // القيَم العددية
    width = 0;
    length = 0;
    height = 0;
    actualWeight = 0;

    // الصورة
    pickedImage = null;
    imageBytes = null;

    // (اختياري) إلغاء التركيز عن أي حقل
    FocusScope.of(context).unfocus();
  }

  // ========= الحساب الصحيح للمتبقي والتقدم =========
  int get _targetTotal => widget.numberOfParcels; // المطلوب الكلي
  int get _alreadyCreated => widget.numberOfCreatedParcels; // الموجود مسبقًا
  int get _inSession => parcels.length; // الذي أضفته الآن في هذه الشاشة
  int get _remaining =>
      (_targetTotal - _alreadyCreated - _inSession).clamp(0, _targetTotal);
  bool get _isLimitReached => _remaining == 0;
  double get _progress =>
      _targetTotal == 0 ? 0.0 : (_alreadyCreated + _inSession) / _targetTotal;

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final bytes = await image.readAsBytes();
      setState(() {
        pickedImage = image;
        imageBytes = bytes;
      });
    }
  }

  int width = 0;
  int length = 0;
  int height = 0;
  int actualWeight = 0;

  final TextEditingController brandController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  bool isFragile = true;
  bool isNeedsRepacking = true;

  // قائمة الطرود التي ستُنشأ في هذه الجلسة فقط
  List<ParcelRequest> parcels = [];

  @override
  void dispose() {
    brandController.dispose();
    notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return BlocProvider(
      create:
          (context) => CreateMultipleParcelsCubit(
            sl.get<CreateMultipleParcelsUseCase>(),
          ),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.grey, AppColors.white],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: BlocConsumer<
              CreateMultipleParcelsCubit,
              CreateMultipleParcelsState
            >(
              listener: (context, state) {
                if (state is CreateMultipleParcelsFailure) {
                  Fluttertoast.showToast(
                    msg: state.message,
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    backgroundColor: Colors.black87,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                }
                if (state is CreateMultipleParcelsSuccess) {
                  Fluttertoast.showToast(
                    msg: 'تم إنشاء الطرود بنجاح',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    backgroundColor: Colors.black87,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );

                  // (اختياري) أرسل إشارة للصفحة السابقة لعمل refresh
                  Navigator.pop(context, {'refresh': true});
                }
              },
              builder: (context, state) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 20.h,
                    horizontal: 30.w,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 700.h,
                                  child: SingleChildScrollView(
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 10.w),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            'إنشاء طرد',
                                            textDirection: TextDirection.ltr,
                                            style: Styles.textStyle6Sp.copyWith(
                                              color: AppColors.goldenYellow,
                                            ),
                                          ),
                                          SizedBox(height: size.height / 20),

                                          // العلامة التجارية
                                          LabeledIconTextField(
                                            svgPicture: SvgPicture.asset(
                                              AssetsData.aLetter,
                                            ),
                                            hintText: 'العلامة التجارية',
                                            controller: brandController,
                                          ),
                                          SizedBox(height: size.height / 30),

                                          // هش/إعادة تعبئة
                                          Container(
                                            width: 110.w,
                                            height: 50.h,
                                            decoration: BoxDecoration(
                                              color: AppColors.white,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                    cornerRadius,
                                                  ),
                                            ),
                                            child: CustomSwitchLabel(
                                              label: 'هش أم لا',
                                              textColor: AppColors.black
                                                  .withValues(alpha: 0.4),
                                              activeColor:
                                                  AppColors.goldenYellow,
                                              disableColor: AppColors.grayDark,
                                              isActive: isFragile,
                                              onChanged:
                                                  (v) => setState(
                                                    () => isFragile = v,
                                                  ),
                                            ),
                                          ),
                                          SizedBox(height: size.height / 30),
                                          Container(
                                            width: 110.w,
                                            height: 50.h,
                                            decoration: BoxDecoration(
                                              color: AppColors.white,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                    cornerRadius,
                                                  ),
                                            ),
                                            child: CustomSwitchLabel(
                                              label:
                                                  'بحاجة لإعادة التعبئة أم لا',
                                              textColor: AppColors.black
                                                  .withValues(alpha: 0.4),
                                              activeColor:
                                                  AppColors.goldenYellow,
                                              disableColor: AppColors.grayDark,
                                              isActive: isNeedsRepacking,
                                              onChanged:
                                                  (v) => setState(
                                                    () => isNeedsRepacking = v,
                                                  ),
                                            ),
                                          ),

                                          SizedBox(height: size.height / 30),

                                          // صورة الميزان
                                          Text(
                                            'رفع صورة الميزان:',
                                            style: Styles.textStyle5Sp,
                                            textDirection: TextDirection.rtl,
                                          ),
                                          SizedBox(height: size.height / 30),
                                          MouseRegion(
                                            cursor: SystemMouseCursors.click,
                                            child: GestureDetector(
                                              onTap: pickImage,
                                              child: Container(
                                                width: 110.w,
                                                height: 180.h,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                child: Center(
                                                  child:
                                                      imageBytes == null
                                                          ? SvgPicture.asset(
                                                            AssetsData.camera,
                                                          )
                                                          : ClipRRect(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  12,
                                                                ),
                                                            child: Image.memory(
                                                              imageBytes!,
                                                              fit: BoxFit.cover,
                                                              width:
                                                                  double
                                                                      .infinity,
                                                              height:
                                                                  double
                                                                      .infinity,
                                                            ),
                                                          ),
                                                ),
                                              ),
                                            ),
                                          ),

                                          SizedBox(height: size.height / 30),

                                          // حساب الأبعاد والوزن
                                          SizedBox(
                                            width: 110.w,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width: 50.w,
                                                  child: CustomOkButton(
                                                    onTap: () async {
                                                      final result =
                                                          await Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder:
                                                                  (_) =>
                                                                      DimensionCalculation(),
                                                            ),
                                                          );
                                                      if (result != null &&
                                                          result
                                                              is Map<
                                                                String,
                                                                int
                                                              >) {
                                                        height =
                                                            result['height']!;
                                                        length =
                                                            result['length']!;
                                                        width =
                                                            result['width']!;
                                                      }
                                                    },
                                                    color:
                                                        AppColors.goldenYellow,
                                                    label: 'حساب الأبعاد',
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 50.w,
                                                  child: CustomOkButton(
                                                    onTap: () async {
                                                      final result =
                                                          await Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder:
                                                                  (_) =>
                                                                      const VolumetricWeightCalculation(),
                                                            ),
                                                          );
                                                      if (result != null &&
                                                          result
                                                              is Map<
                                                                String,
                                                                dynamic
                                                              >) {
                                                        actualWeight =
                                                            result['actualWeight'] ??
                                                            0;
                                                      }
                                                    },
                                                    color:
                                                        AppColors.goldenYellow,
                                                    label: 'حساب الحجم',
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),

                                          SizedBox(height: size.height / 30),

                                          // ملاحظات
                                          CustomNote(
                                            label: 'ملاحظات عامة:',
                                            controller: notesController,
                                          ),

                                          SizedBox(height: size.height / 30),

                                          // كرت الحالة (المتبقي/التقدم)
                                          Container(
                                            width: 110.w,
                                            padding: EdgeInsets.symmetric(
                                              vertical: 8.h,
                                              horizontal: 8.w,
                                            ),
                                            decoration: BoxDecoration(
                                              color: AppColors.white,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                    cornerRadius,
                                                  ),
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 1,
                                                  spreadRadius: 0.2,
                                                  color: Colors.black12,
                                                ),
                                              ],
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              children: [
                                                Text(
                                                  _isLimitReached
                                                      ? 'اكتمل العدد المطلوب ($_targetTotal)'
                                                      : 'المطلوب: $_targetTotal | المُنشأ: $_alreadyCreated | أضفته الآن: $_inSession | المتبقي: $_remaining',
                                                  textAlign: TextAlign.center,
                                                  style: Styles.textStyle5Sp
                                                      .copyWith(
                                                        color:
                                                            _isLimitReached
                                                                ? Colors
                                                                    .redAccent
                                                                : AppColors
                                                                    .deepPurple,
                                                      ),
                                                ),
                                                SizedBox(height: 6.h),
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  child:
                                                      LinearProgressIndicator(
                                                        value: _progress,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ),

                                          SizedBox(height: size.height / 30),

                                          // زر "حفظ" (إضافة طرد واحد إلى جلسة الإدخال)
                                          Opacity(
                                            opacity: _isLimitReached ? 0.5 : 1,
                                            child: IgnorePointer(
                                              ignoring: _isLimitReached,
                                              child: CustomOkButton(
                                                onTap: () async {
                                                  if (_isLimitReached) {
                                                    Fluttertoast.showToast(
                                                      msg:
                                                          'لا يوجد متبقٍ لإضافته',
                                                    );
                                                    return;
                                                  }
                                                  if (notesController
                                                          .text
                                                          .isEmpty ||
                                                      brandController
                                                          .text
                                                          .isEmpty ||
                                                      pickedImage == null) {
                                                    Fluttertoast.showToast(
                                                      msg:
                                                          'أدخل البيانات كاملة',
                                                      toastLength:
                                                          Toast.LENGTH_SHORT,
                                                      gravity:
                                                          ToastGravity.CENTER,
                                                      backgroundColor:
                                                          Colors.black87,
                                                      textColor: Colors.white,
                                                      fontSize: 16.0,
                                                    );
                                                    return;
                                                  }
                                                  if (height == 0 ||
                                                      length == 0 ||
                                                      width == 0 ||
                                                      actualWeight == 0) {
                                                    Fluttertoast.showToast(
                                                      msg:
                                                          'لا يجوز أن يكون هناك أبعاد/وزن صفري',
                                                      toastLength:
                                                          Toast.LENGTH_SHORT,
                                                      gravity:
                                                          ToastGravity.CENTER,
                                                      backgroundColor:
                                                          Colors.black87,
                                                      textColor: Colors.white,
                                                      fontSize: 16.0,
                                                    );
                                                    return;
                                                  }

                                                  // صفحة عناصر الطرد — تعيد ParcelRequest واحد
                                                  final result =
                                                      await Navigator.pushNamed(
                                                        context,
                                                        Routes
                                                            .createParcelItemScreen,
                                                        arguments: {
                                                          "id":
                                                              widget.shipmentId,
                                                          "length": length,
                                                          "width": width,
                                                          "height": height,
                                                          "brand_type":
                                                              brandController
                                                                  .text,
                                                          "is_fragile":
                                                              isFragile,
                                                          "needs_repacking":
                                                              isNeedsRepacking,
                                                          "notes":
                                                              notesController
                                                                  .text,
                                                          "actual_weight":
                                                              actualWeight,
                                                          "scale_photo_upload":
                                                              pickedImage!,
                                                        },
                                                      );

                                                  if (!mounted) return;

                                                  if (result != null &&
                                                      result is ParcelRequest) {
                                                    // لا تسمح بتجاوز المتبقي (تحقّق إضافي)
                                                    if (_remaining <= 0) {
                                                      Fluttertoast.showToast(
                                                        msg:
                                                            'وصلت للحد المطلوب',
                                                      );
                                                      return;
                                                    }
                                                    setState(() {
                                                      parcels.add(
                                                        result,
                                                      ); // نخزّن الطرد نهائيًا
                                                      _resetDraft(); // نفرّغ الحقول لبدء طرد جديد
                                                    });
                                                    Fluttertoast.showToast(
                                                      msg:
                                                          'تمت إضافة طرد (عناصر: ${result.items.length}). المتبقي الآن: $_remaining',
                                                    );
                                                  }
                                                },
                                                color: AppColors.goldenYellow,
                                                label: 'حفظ',
                                              ),
                                            ),
                                          ),

                                          SizedBox(height: 16.h),

                                          // زر "إنهاء الطلب" (إرسال ما أضفته الآن فقط)
                                          state is CreateMultipleParcelsLoading
                                              ? const CustomProgressIndicator()
                                              : Opacity(
                                                opacity:
                                                    (_isLimitReached &&
                                                            parcels.isNotEmpty)
                                                        ? 1
                                                        : (parcels.isNotEmpty
                                                            ? 1
                                                            : 0.5),
                                                child: IgnorePointer(
                                                  ignoring:
                                                      parcels.length !=
                                                      widget.numberOfParcels,
                                                  child: CustomOkButton(
                                                    onTap: () {
                                                      if (parcels.isEmpty) {
                                                        Fluttertoast.showToast(
                                                          msg:
                                                              'أضف طردًا واحدًا على الأقل',
                                                        );
                                                        return;
                                                      }
                                                      // نُرسل فقط ما أُضيف في هذه الجلسة
                                                      context
                                                          .read<
                                                            CreateMultipleParcelsCubit
                                                          >()
                                                          .createMultipleParcels(
                                                            shipmentId:
                                                                widget
                                                                    .shipmentId,
                                                            parcels: parcels,
                                                          );
                                                    },
                                                    color: AppColors.deepPurple,
                                                    label: "إنهاء الطلب",
                                                  ),
                                                ),
                                              ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
