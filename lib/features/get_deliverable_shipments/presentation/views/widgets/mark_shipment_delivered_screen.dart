import 'dart:typed_data';

import 'package:final_subul_project/core/helpers/extensions.dart';
import 'package:final_subul_project/core/routing/routes.dart';
import 'package:final_subul_project/core/utils/functions/show_snack_bar.dart';
import 'package:final_subul_project/features/get_deliverable_shipments/presentation/managers/mark_shipment_delivered_cubit/mark_shipment_delivered_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:final_subul_project/core/helpers/assets_data.dart';
import 'package:final_subul_project/core/helpers/constants.dart';
import 'package:final_subul_project/core/helpers/styles.dart';
import 'package:final_subul_project/core/theming/app_colors.dart';
import 'package:final_subul_project/core/widgets/custom_ok_button.dart';
import 'package:final_subul_project/core/widgets/custom_progress_indicator.dart';

class MarkShipmentDeliveredScreen extends StatefulWidget {
  final int id;
  const MarkShipmentDeliveredScreen({super.key, required this.id});

  @override
  State<MarkShipmentDeliveredScreen> createState() =>
      _MarkShipmentDeliveredScreenState();
}

class _MarkShipmentDeliveredScreenState
    extends State<MarkShipmentDeliveredScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent,leading: IconButton(onPressed: (){
         context.pushNamedAndRemoveUntil(
              Routes.warehouseManager,
              predicate: (Route<dynamic> route) => false,
            );
      }, icon: Icon(Icons.arrow_back,)),),
      backgroundColor: AppColors.lightGray2,
      body: Center(
        child: Container(
          width: 100.w,
          height: 300.h,
          decoration: BoxDecoration(
            color: AppColors.lightGray,
            borderRadius: BorderRadius.circular(cornerRadius),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('رفع الصورة', style: Styles.textStyle4Sp),
              SizedBox(height: 5.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: pickImage,
                    child: Container(
                      width: 110.w,
                      height: 180.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child:
                            imageBytes == null
                                ? SvgPicture.asset(AssetsData.camera)
                                : ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.memory(
                                    imageBytes!,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: double.infinity,
                                  ),
                                ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              BlocConsumer<
                MarkShipmentDeliveredCubit,
                MarkShipmentDeliveredState
              >(
                builder: (context, state) {
                  return state is MarkShipmentDeliveredLoading
                      ? CustomProgressIndicator()
                      : CustomOkButton(
                        onTap: () {
                          if (pickedImage == null) {
                            return;
                          }
                          context
                              .read<MarkShipmentDeliveredCubit>()
                              .markShipmentDelivered(
                                shipmentId: widget.id,
                                deliveryPhoto: pickedImage!,
                              );
                        },
                        color: AppColors.goldenYellow,
                        label: 'حفظ',
                      );
                },
                listener: (
                  BuildContext context,
                  MarkShipmentDeliveredState state,
                ) {
                  if (state is MarkShipmentDeliveredFailure) {
                    showToastMsg(context, state.message);
                  }

                  if (state is MarkShipmentDeliveredSuccess) {
                   // showToastMsg(context, "تمت العملية بنجاح");
                    context.pop();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
