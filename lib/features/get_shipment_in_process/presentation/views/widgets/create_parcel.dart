import 'dart:typed_data';

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
import 'package:final_subul_project/core/widgets/custom_icon_of_side_bar.dart';
import 'package:final_subul_project/core/widgets/custom_ok_button.dart';
import 'package:final_subul_project/core/widgets/custom_progress_indicator.dart';
import 'package:final_subul_project/core/widgets/custom_switch_label.dart';
import 'package:final_subul_project/core/widgets/text_logo.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/use_case/create_parcel_use_case/create_parcel_use_case.dart';
import 'package:final_subul_project/features/get_shipment_in_process/presentation/manager/create_parcel_cubit/create_parcel_cubit.dart';
import 'package:final_subul_project/features/warehouse_manager/ui/widgets/custom_note.dart';
import 'package:final_subul_project/features/warehouse_manager/ui/widgets/dimension_calculation.dart';
import 'package:final_subul_project/features/warehouse_manager/ui/widgets/labeled_icon_text_field.dart';
import 'package:final_subul_project/features/warehouse_manager/ui/widgets/labeled_input_field.dart';
import 'package:final_subul_project/features/warehouse_manager/ui/widgets/volumetric_weight_calculation.dart';

class CreateParcel extends StatefulWidget {
  const CreateParcel({super.key, required this.shipmentId});
  final int shipmentId;

  @override
  State<CreateParcel> createState() => _CreateParcelState();
}

class _CreateParcelState extends State<CreateParcel> {
  XFile? pickedImage;
  Uint8List? imageBytes;

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
  int normalDimensionalWeight = 0;
  int specialDimensionalWeight = 0;
  int normalActualWeight = 0;
  int specialActualWeight = 0;
  int actualWeight = 0;
  final TextEditingController brandController = TextEditingController();
  final TextEditingController notesController = TextEditingController();
  final TextEditingController printNotesController = TextEditingController();
  bool isFragile = true;
  bool isNeedsRepacking = true;
  @override
  void dispose() {
    brandController.dispose();
    notesController.dispose();
    printNotesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => CreateParcelCubit(sl.get<CreateParcelUseCase>()),
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
            child: BlocConsumer<CreateParcelCubit, CreateParcelState>(
              listener: (context, state) {
                if (state is CreateParcelFailure) {
                  Fluttertoast.showToast(
                    msg: state.message,
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    backgroundColor: Colors.black87,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                }
                if (state is CreateParcelSuccess) {
                  Fluttertoast.showToast(
                    msg: 'تم انشاء الطرد بنجاح',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    backgroundColor: Colors.black87,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                  context.pop();
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
                      // Stack(
                      //   children: [
                      //     Column(
                      //       mainAxisAlignment: MainAxisAlignment.start,
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       children: [
                      //         Padding(
                      //           padding: EdgeInsets.only(left: 10.w, top: 40.h),
                      //           child: TextLogo(),
                      //         ),
                      //         SizedBox(height: size.height / 10),
                      //         Container(
                      //           width: 20.w,
                      //           height: 900.h,
                      //           decoration: BoxDecoration(
                      //             color: AppColors.goldenYellow,
                      //             borderRadius: BorderRadius.only(
                      //               topRight: Radius.circular(120),
                      //               topLeft: Radius.circular(10),
                      //             ),
                      //           ),
                      //           child: Column(
                      //             mainAxisAlignment: MainAxisAlignment.center,
                      //             children: [
                      //               CustomIconOfSideBar(
                      //                 icon: Icons.add,
                      //                 color: AppColors.white,
                      //                 onTap: () {},
                      //                 isSelected: false,
                      //               ),
                      //               SizedBox(height: size.height / 10),
                      //               CustomIconOfSideBar(
                      //                 icon: Icons.local_shipping,
                      //                 color: AppColors.white,
                      //                 onTap: () {},
                      //                 isSelected: false,
                      //               ),
                      //               SizedBox(height: size.height / 10),
                      //               CustomIconOfSideBar(
                      //                 image: AssetsData.boxShipmmentIcon,
                      //                 onTap: () {},
                      //                 isSelected: false,
                      //               ),
                      //             ],
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ],
                      // ),
                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Column(
                                //   children: [
                                //     // Text(
                                //     //   'قسم العد:',
                                //     //   style: Styles.textStyle5Sp.copyWith(
                                //     //     color: AppColors.goldenYellow,
                                //     //   ),
                                //     //   textDirection: TextDirection.rtl,
                                //     // ),
                                //     // SizedBox(height: size.height / 50),
                                //     // SizedBox(
                                //     //   width: 100.w,
                                //     //   height: 200.h,
                                //     //   child: SingleChildScrollView(
                                //     //     child: Table(
                                //     //       border: TableBorder.all(
                                //     //         color: AppColors.deepPurple,
                                //     //         width: 1.5,
                                //     //       ),
                                //     //       columnWidths: {
                                //     //         0: FlexColumnWidth(1),
                                //     //         1: FlexColumnWidth(1),
                                //     //       },
                                //     //       children: [
                                //     //         TableRow(
                                //     //           children: [
                                //     //             tableHeader('العدد'),
                                //     //             tableHeader('العنصر'),
                                //     //           ],
                                //     //         ),
                                //     //         ...List.generate(10, (_) {
                                //     //           return TableRow(
                                //     //             children: [
                                //     //               tableCell('5'),
                                //     //               tableCell('كتب'),
                                //     //             ],
                                //     //           );
                                //     //         }),
                                //     //       ],
                                //     //     ),
                                //     //   ),
                                //     // ),
                                //     // SizedBox(height: size.height / 10),
                                //     // Text(
                                //     //   'محتوى الطرد:',
                                //     //   style: Styles.textStyle5Sp.copyWith(
                                //     //     color: AppColors.goldenYellow,
                                //     //   ),
                                //     //   textDirection: TextDirection.rtl,
                                //     // ),
                                //     // SizedBox(height: size.height / 50),
                                //     // SizedBox(
                                //     //   width: 100.w,
                                //     //   height: 200.h,
                                //     //   child: SingleChildScrollView(
                                //     //     child: Table(
                                //     //       border: TableBorder.all(
                                //     //         color: AppColors.deepPurple,
                                //     //         width: 1.5,
                                //     //       ),
                                //     //       columnWidths: {
                                //     //         0: FlexColumnWidth(1),
                                //     //         1: FlexColumnWidth(1),
                                //     //       },
                                //     //       children: [
                                //     //         TableRow(
                                //     //           children: [
                                //     //             tableHeader('العدد'),
                                //     //             tableHeader('نوع المحتوى'),
                                //     //           ],
                                //     //         ),
                                //     //         ...List.generate(10, (_) {
                                //     //           return TableRow(
                                //     //             children: [
                                //     //               tableCell('5'),
                                //     //               tableCell('كتب'),
                                //     //             ],
                                //     //           );
                                //     //         }),
                                //     //       ],
                                //     //     ),
                                //     //   ),
                                //     // ),
                                //     SizedBox(height: size.height / 10),
                                //   ],
                                // ),
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
                                            'انشاء طرد',
                                            textDirection: TextDirection.ltr,
                                            style: Styles.textStyle6Sp.copyWith(
                                              color: AppColors.goldenYellow,
                                            ),
                                          ),
                                          SizedBox(height: size.height / 20),
                                          // LabeledIconTextField(
                                          //   svgPicture: SvgPicture.asset(
                                          //     AssetsData.persons,
                                          //   ),
                                          //   hintText: 'اختيار العميل',
                                          // ),
                                          // SizedBox(height: size.height / 30),
                                          // LabeledIconTextField(
                                          //   svgPicture: SvgPicture.asset(
                                          //     AssetsData.outlineBox,
                                          //   ),
                                          //   hintText: 'رمز الشحنة',
                                          // ),
                                          // SizedBox(height: size.height / 30),
                                          // LabeledIconTextField(
                                          //   svgPicture: SvgPicture.asset(
                                          //     AssetsData.bulb,
                                          //   ),
                                          //   hintText: 'اختيار البلد المصدر',
                                          // ),
                                          // SizedBox(height: size.height / 30),
                                          // LabeledIconTextField(
                                          //   svgPicture: SvgPicture.asset(
                                          //     AssetsData.bulb,
                                          //   ),
                                          //   hintText: 'اختيار البلد الوجهة',
                                          // ),
                                          // SizedBox(height: size.height / 30),
                                          // LabeledIconTextField(
                                          //   svgPicture: SvgPicture.asset(
                                          //     AssetsData.persons,
                                          //   ),
                                          //   hintText: 'اختيار البائعين',
                                          // ),
                                          // SizedBox(height: size.height / 30),
                                          LabeledIconTextField(
                                            svgPicture: SvgPicture.asset(
                                              AssetsData.aLetter,
                                            ),
                                            hintText: 'العلامة التجارية',
                                            controller: brandController,
                                          ),
                                          SizedBox(height: size.height / 30),
                                          // LabeledIconTextField(
                                          //   svgPicture: SvgPicture.asset(
                                          //     AssetsData.outlineBox,
                                          //   ),
                                          //   hintText: 'طلب شحن',
                                          // ),
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
                                              label: 'هش أم لا',
                                              textColor: AppColors.black
                                                  .withValues(alpha: 0.4),
                                              activeColor:
                                                  AppColors.goldenYellow,
                                              disableColor: AppColors.grayDark,
                                              isActive: isFragile,
                                              onChanged: (value) {
                                                setState(() {
                                                  isFragile = value;
                                                });
                                              },
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
                                              onChanged: (value) {
                                                setState(() {
                                                  isNeedsRepacking = value;
                                                });
                                              },
                                            ),
                                          ),
                                          SizedBox(height: size.height / 30),
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
                                          // Text(
                                          //   'المالية:',
                                          //   style: Styles.textStyle5Sp,
                                          //   textDirection: TextDirection.rtl,
                                          // ),
                                          // SizedBox(height: size.height / 30),
                                          // LabeledInputField(
                                          //   label: 'المبلغ المدفوع',
                                          // ),
                                          // SizedBox(height: size.height / 30),
                                          // LabeledInputField(label: 'عنوان العميل'),
                                          // SizedBox(height: size.height / 30),
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

                                                        specialActualWeight =
                                                            result['specialActualWeight'] ??
                                                            0;
                                                        normalActualWeight =
                                                            result['normalActualWeight'] ??
                                                            0;

                                                        specialDimensionalWeight =
                                                            result['specialDimensionalWeight'] ??
                                                            0;

                                                        normalDimensionalWeight =
                                                            result['normalDimensionalWeight'] ??
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
                                          CustomNote(
                                            label: 'ملاحظات عامة:',
                                            controller: notesController,
                                          ),
                                          SizedBox(height: size.height / 30),
                                          CustomNote(
                                            label: 'ملاحظات طباعة:',
                                            controller: printNotesController,
                                          ),
                                          SizedBox(height: size.height / 30),
                                          state is CreateParcelLoading
                                              ? CustomProgressIndicator()
                                              : CustomOkButton(
                                                onTap: () {
                                                  if (notesController
                                                          .text
                                                          .isEmpty ||
                                                      printNotesController
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
                                                      actualWeight == 0 ||
                                                      specialActualWeight ==
                                                          0 ||
                                                      normalActualWeight == 0 ||
                                                      specialDimensionalWeight ==
                                                          0 ||
                                                      normalDimensionalWeight ==
                                                          0) {
                                                    Fluttertoast.showToast(
                                                      msg:
                                                          'لا يجوز أن يكون هناك أبعاد صفرية',
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
                                                  context
                                                      .read<CreateParcelCubit>()
                                                      .createParcel(
                                                        id: widget.shipmentId,
                                                        actualWeight:
                                                            actualWeight,
                                                        specialActualWeight:
                                                            specialActualWeight,
                                                        normalActualWeight:
                                                            normalActualWeight,
                                                        specialDimensionalWeight:
                                                            specialDimensionalWeight,
                                                        normalDimensionalWeight:
                                                            normalDimensionalWeight,
                                                        length: length,
                                                        width: width,
                                                        height: height,
                                                        brandType:
                                                            brandController
                                                                .text,
                                                        isFragile: isFragile,
                                                        needsRepacking:
                                                            isNeedsRepacking,
                                                        notes:
                                                            notesController
                                                                .text,
                                                        printNotes:
                                                            printNotesController
                                                                .text,
                                                        scalePhotoUpload:
                                                            pickedImage!,
                                                      );
                                                },
                                                color: AppColors.goldenYellow,
                                                label: 'حفظ',
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

// Widget tableHeader(String text) {
//   return Container(
//     padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 12.h),
//     alignment: Alignment.center,
//     color: Colors.transparent,
//     child: Text(
//       text,
//       style: Styles.textStyle5Sp.copyWith(color: AppColors.goldenYellow),
//       textDirection: TextDirection.rtl,
//     ),
//   );
// }

// Widget tableCell(String text) {
//   return Container(
//     padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 12.h),
//     alignment: Alignment.center,
//     child: Text(
//       text,
//       style: Styles.textStyle5Sp.copyWith(color: AppColors.deepPurple),
//       textDirection: TextDirection.rtl,
//     ),
//   );
// }
