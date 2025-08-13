import 'dart:typed_data';

import 'package:final_subul_project/core/routing/routes.dart';
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
import 'package:final_subul_project/core/theming/app_colors.dart';
import 'package:final_subul_project/core/widgets/custom_ok_button.dart';
import 'package:final_subul_project/core/widgets/custom_progress_indicator.dart';
import 'package:final_subul_project/features/get_shipments_in_the_way/presentation/manager/update_shipments_warehouse_arrival_cubit/update_shipments_warehouse_arrival_cubit.dart';

class UpdateShipmentsWarehouseArrivalScreen extends StatefulWidget {
  final int id;
  const UpdateShipmentsWarehouseArrivalScreen({super.key, required this.id});

  @override
  State<UpdateShipmentsWarehouseArrivalScreen> createState() =>
      _UpdateShipmentsWarehouseArrivalScreenState();
}

class _UpdateShipmentsWarehouseArrivalScreenState
    extends State<UpdateShipmentsWarehouseArrivalScreen> {
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
              Text('صورة إيصال المطار', style: Styles.textStyle4Sp),
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
                UpdateShipmentsWarehouseArrivalCubit,
                UpdateShipmentsWarehouseArrivalState
              >(
                builder: (context, state) {
                  return state is UpdateShipmentsWarehouseArrivalLoading
                      ? CustomProgressIndicator()
                      : CustomOkButton(
                        onTap: () {
                          if (pickedImage == null) {
                            return;
                          }
                          context
                              .read<UpdateShipmentsWarehouseArrivalCubit>()
                              .updateShipment(
                                id: widget.id,
                                image: pickedImage!,
                              );
                        },
                        color: AppColors.goldenYellow,
                        label: 'حفظ',
                      );
                },
                listener: (
                  BuildContext context,
                  UpdateShipmentsWarehouseArrivalState state,
                ) {
                  if (state is UpdateShipmentsWarehouseArrivalFailure) {
                    Fluttertoast.showToast(
                      msg: state.message,
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      backgroundColor: Colors.black87,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                  }
                  if (state is UpdateShipmentsWarehouseArrivalSuccess) {
                    Fluttertoast.showToast(
                      msg: 'تمت العملية بنجاح',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      backgroundColor: Colors.black87,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                     context.pushNamed(
                            Routes.showSpecificParcelsOfInTheWayShipments,
                            arguments: widget.id,
                          );
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
