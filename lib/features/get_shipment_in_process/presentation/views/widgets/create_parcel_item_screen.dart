import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:final_subul_project/core/helpers/assets_data.dart';
import 'package:final_subul_project/core/helpers/extensions.dart';
import 'package:final_subul_project/core/widgets/custom_ok_button.dart';
import 'package:final_subul_project/core/widgets/custom_progress_indicator.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/entities/allowed_content_entity/allowed_content_entity.dart';
import 'package:final_subul_project/features/get_shipment_in_process/presentation/manager/create_parcel_item_cubit/create_parcel_item_cubit.dart';
import 'package:final_subul_project/features/get_shipment_in_process/presentation/manager/get_allowed_content_cubit/get_allowed_content_cubit.dart';
import 'package:final_subul_project/features/warehouse_manager/ui/widgets/generic_dropdown_field.dart';

import '../../../../../core/theming/app_colors.dart';
import '../../../../warehouse_manager/ui/widgets/labeled_icon_text_field.dart';

class CreateParcelItemScreen extends StatefulWidget {
  final int id;
  const CreateParcelItemScreen({super.key, required this.id});

  @override
  State<CreateParcelItemScreen> createState() => _CreateParcelItemScreenState();
}

class _CreateParcelItemScreenState extends State<CreateParcelItemScreen> {
  TextEditingController quantityController = TextEditingController();
  TextEditingController valuePerItemController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String? selectedType;
  AllowedContentEntity? selctedAllowedContentEntity;

  @override
  void dispose() {
    quantityController.dispose();
    valuePerItemController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGray,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<GetAllowedContentCubit, GetAllowedContentState>(
              builder: (context, state) {
                if (state is GetAllowedContentSuccess) {
                  return GenericDropdownField<AllowedContentEntity>(
                    items: state.contents,
                    selectedItem: selctedAllowedContentEntity,
                    onChanged:
                        (value) =>
                            setState(() => selectedType = value!.content),
                    itemAsString: (c) => c.content,
                    hintText: 'الأنواع المسموحة',
                    svgIcon: SvgPicture.asset(AssetsData.bulb, height: 20.h),
                    validator:
                        (value) =>
                            value == null ? 'الرجاء اختيار النوع ' : null,
                  );
                } else if (state is GetAllowedContentLoading) {
                  return CustomProgressIndicator();
                } else {
                  return Container();
                }
              },
            ),
            SizedBox(height: 16.h),
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
            BlocConsumer<CreateParcelItemCubit, CreateParcelItemState>(
              listener: (context, state) {
                if (state is CreateParcelItemFailure) {
                  Fluttertoast.showToast(
                    msg: state.message,
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    backgroundColor: Colors.black87,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                }
                if (state is CreateParcelItemSuccess) {
                  Fluttertoast.showToast(
                    msg: 'تمت العملية بنجاح',
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
                return state is CreateParcelItemLoading
                    ? CustomProgressIndicator()
                    : CustomOkButton(
                      onTap: () {
                        print(selectedType);
                        if (selectedType == null ||
                            quantityController.text.isEmpty ||
                            valuePerItemController.text.isEmpty ||
                            descriptionController.text.isEmpty) {
                          return;
                        }
                        context.read<CreateParcelItemCubit>().createParcelItem(
                          type: selectedType!,
                          quantity: int.parse(quantityController.text),
                          valuePerItem: int.parse(valuePerItemController.text),
                          description: descriptionController.text,
                          id: widget.id,
                        );
                      },
                      color: AppColors.goldenYellow,
                      label: 'حفظ',
                    );
              },
            ),
          ],
        ),
      ),
    );
  }
}
