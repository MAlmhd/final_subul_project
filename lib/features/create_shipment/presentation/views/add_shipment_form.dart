import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:final_subul_project/core/helpers/assets_data.dart';
import 'package:final_subul_project/core/helpers/styles.dart';
import 'package:final_subul_project/core/theming/app_colors.dart';
import 'package:final_subul_project/core/utils/functions/show_snack_bar.dart';
import 'package:final_subul_project/core/widgets/custom_input_field.dart';
import 'package:final_subul_project/core/widgets/custom_progress_indicator.dart';
import 'package:final_subul_project/features/create_shipment/domain/entities/country_entity/country_entity.dart';
import 'package:final_subul_project/features/create_shipment/domain/entities/user_entity/user_entity.dart';
import 'package:final_subul_project/features/create_shipment/presentation/manager/create_shipment_cubit/create_shipment_cubit.dart';
import 'package:final_subul_project/features/create_shipment/presentation/manager/get_countries_cubit/get_countries_cubit.dart';
import 'package:final_subul_project/features/create_shipment/presentation/manager/get_users_cubit/get_users_cubit.dart';
import 'package:final_subul_project/features/warehouse_manager/ui/widgets/generic_dropdown_field.dart';
import 'package:final_subul_project/features/warehouse_manager/ui/widgets/tracking_number_card.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddShipmentForm extends StatefulWidget {
  const AddShipmentForm({super.key});

  @override
  State<AddShipmentForm> createState() => _AddShipmentFormState();
}

class _AddShipmentFormState extends State<AddShipmentForm> {
  final _formKey = GlobalKey<FormState>();
  UserEntity? selectedCustomer;
  CountryEntity? selectedOriginCountry;
  CountryEntity? selectedDestinitionCountry;
  List<CountryEntity> countries = [];
  List<String> typeOfShipments = ['ship_pay', 'ship_only', 'pay_only'];
  String? selectedType;
  String? numberTracking;

  final TextEditingController supplierNameController = TextEditingController();
  final TextEditingController supplierNumberController =
      TextEditingController();
  final TextEditingController declaredParcelsCountController =
      TextEditingController();
  final TextEditingController notesController = TextEditingController();

  @override
  void dispose() {
    supplierNameController.dispose();
    supplierNumberController.dispose();
    declaredParcelsCountController.dispose();
    notesController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    context.read<GetUsersCubit>().getUser();
    context.read<GetCountriesCubit>().getCountries();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Flexible(child: SvgPicture.asset(AssetsData.ballon, width: 80.w)),
            ],
          ),
          SizedBox(height: size.height / 20),

          BlocBuilder<GetUsersCubit, GetUsersState>(
            builder: (context, state) {
              List<UserEntity> users = [];
              if (state is GetUsersSuccess) {
                users = state.users;
              }

              return GenericDropdownField<UserEntity>(
                items: users,
                selectedItem: selectedCustomer,
                onChanged: (value) => setState(() => selectedCustomer = value),
                itemAsString: (c) => c.firstName,
                hintText: 'اسم العميل',
                svgIcon: SvgPicture.asset(AssetsData.person, height: 20.h),
                validator:
                    (value) => value == null ? 'الرجاء اختيار العميل' : null,
              );
            },
          ),

          SizedBox(height: size.height / 20),

          BlocBuilder<GetCountriesCubit, GetCountriesState>(
            builder: (context, state) {
              if (state is GetCountriesSuccess) {
                countries = state.countries;
              }

              return GenericDropdownField<CountryEntity>(
                items: countries,
                selectedItem: selectedOriginCountry,
                onChanged:
                    (value) => setState(() => selectedOriginCountry = value),
                itemAsString: (c) => c.name,
                hintText: 'البلد المصدر',
                svgIcon: SvgPicture.asset(AssetsData.bulb, height: 20.h),
                validator:
                    (value) =>
                        value == null ? 'الرجاء اختيار البلد المصدر' : null,
              );
            },
          ),

          SizedBox(height: size.height / 20),

          GenericDropdownField<CountryEntity>(
            items: countries,
            selectedItem: selectedDestinitionCountry,
            onChanged:
                (value) => setState(() => selectedDestinitionCountry = value),
            itemAsString: (c) => c.name,
            hintText: 'البلد الوجهة',
            svgIcon: SvgPicture.asset(AssetsData.bulb, height: 20.h),
            validator:
                (value) => value == null ? 'الرجاء اختيار البلد الوجهة' : null,
          ),

          SizedBox(height: size.height / 20),

          GenericDropdownField<String>(
            items: typeOfShipments,
            selectedItem: selectedType,
            onChanged: (value) => setState(() => selectedType = value),
            itemAsString: (c) => c,
            hintText: 'نوع الشحنة',
            svgIcon: SvgPicture.asset(
              AssetsData.outlinePurpleBox,
              height: 20.h,
            ),
            validator:
                (value) => value == null ? 'الرجاء اختيار نوع الشحنة' : null,
          ),

          SizedBox(height: size.height / 20),

          CustomInputField(
            controller: supplierNameController,
            hintText: 'اسم المزود',
            svgPicture: SvgPicture.asset(AssetsData.persons, height: 15.h),
            validator:
                (value) =>
                    value == null || value.isEmpty
                        ? 'يرجى إدخال اسم المزود'
                        : null,
          ),

          SizedBox(height: size.height / 20),

          CustomInputField(
            controller: supplierNumberController,
            hintText: 'رقم المزود',
            svgPicture: SvgPicture.asset(AssetsData.phone, height: 15.h),
            validator:
                (value) =>
                    value == null || value.isEmpty
                        ? 'يرجى إدخال رقم المزود'
                        : null,
          ),

          SizedBox(height: size.height / 20),

          CustomInputField(
            controller: declaredParcelsCountController,
            hintText: 'عدد الطرود',
            svgPicture: SvgPicture.asset(AssetsData.boxNotFilled, height: 15.h),
            validator:
                (value) =>
                    value == null || value.isEmpty
                        ? 'يرجى إدخال عدد الطرود'
                        : null,
          ),

          SizedBox(height: size.height / 20),

          CustomInputField(
            controller: notesController,
            hintText: 'ملاحظات',
            svgPicture: SvgPicture.asset(AssetsData.notesIcon, height: 15.h),
            validator:
                (value) =>
                    value == null || value.isEmpty
                        ? 'يرجى إدخال الملاحظات'
                        : null,
          ),

          SizedBox(height: size.height / 20),

          BlocConsumer<CreateShipmentCubit, CreateShipmentState>(
            listener: (context, state) {
              if (state is CreateShipmentSuccess) {
                Fluttertoast.showToast(
                  msg: "تم انشاء الشحنة بنجاح",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  backgroundColor: Colors.black87,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
                setState(() {
                  selectedCustomer = null;
                  selectedOriginCountry = null;
                  selectedDestinitionCountry = null;
                  selectedType = null;
                });

                supplierNameController.clear();
                supplierNumberController.clear();
                declaredParcelsCountController.clear();
                notesController.clear();

                _formKey.currentState?.reset();
              } else if (state is CreateShipmentFailure) {
                Fluttertoast.showToast(
                  msg: state.message,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  backgroundColor: Colors.black87,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
              }
            },
            builder: (context, state) {
              return MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<CreateShipmentCubit>().createShipment(
                        type: selectedType!,
                        customerId: selectedCustomer!.id,
                        supplierName: supplierNameController.text,
                        supplierNumber: supplierNumberController.text,
                        declaredParcelsCount:
                            declaredParcelsCountController.text,
                        notes: notesController.text,
                        destenationCountryId: selectedDestinitionCountry!.id,
                        originCountryId: selectedOriginCountry!.id,
                      );
                    }
                  },
                  child:
                      state is CreateShipmentLoading
                          ? CustomProgressIndicator()
                          : Container(
                            width: 50.w,
                            height: 40.h,
                            decoration: BoxDecoration(
                              color: AppColors.goldenYellow,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                width: 1,
                                color: AppColors.deepGray,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'موافق',
                                style: Styles.textStyle4Sp.copyWith(
                                  color: AppColors.black.withValues(alpha: 0.4),
                                ),
                              ),
                            ),
                          ),
                ),
              );
            },
          ),

          SizedBox(height: size.height / 20),

          numberTracking != null
              ? TrackNumberCard(number: '$numberTracking')
              : SizedBox(),
        ],
      ),
    );
  }
}
