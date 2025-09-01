import 'dart:typed_data';

import 'package:final_subul_project/core/utils/functions/show_snack_bar.dart';
import 'package:final_subul_project/core/widgets/upload_image.dart';
import 'package:final_subul_project/features/create_shipment/domain/entities/supplier_entity/supplier_entity.dart';
import 'package:final_subul_project/features/create_shipment/presentation/manager/get_suppliers_cubit/get_suppliers_cubit.dart';
import 'package:final_subul_project/features/create_shipment/presentation/views/widgets/multi_select_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:final_subul_project/core/helpers/assets_data.dart';
import 'package:final_subul_project/core/helpers/styles.dart';
import 'package:final_subul_project/core/theming/app_colors.dart';
import 'package:final_subul_project/core/widgets/custom_input_field.dart';
import 'package:final_subul_project/core/widgets/custom_progress_indicator.dart';
import 'package:final_subul_project/features/create_shipment/domain/entities/country_entity/country_entity.dart';
import 'package:final_subul_project/features/create_shipment/domain/entities/user_entity/user_entity.dart';
import 'package:final_subul_project/features/create_shipment/presentation/manager/create_shipment_cubit/create_shipment_cubit.dart';
import 'package:final_subul_project/features/create_shipment/presentation/manager/get_countries_cubit/get_countries_cubit.dart';
import 'package:final_subul_project/features/create_shipment/presentation/manager/get_users_cubit/get_users_cubit.dart';
import 'package:final_subul_project/features/warehouse_manager/ui/widgets/generic_dropdown_field.dart';
import 'package:final_subul_project/features/warehouse_manager/ui/widgets/tracking_number_card.dart';
import 'package:image_picker/image_picker.dart';

class AddShipmentForm extends StatefulWidget {
  const AddShipmentForm({super.key});

  @override
  State<AddShipmentForm> createState() => _AddShipmentFormState();
}

class _AddShipmentFormState extends State<AddShipmentForm> {
  bool get isPayOnly => selectedType == 'pay_only';

  final _formKey = GlobalKey<FormState>();

  UserEntity? selectedCustomer;
  CountryEntity? selectedOriginCountry;
  CountryEntity? selectedDestinitionCountry;
  SupplierEntity? selectedSupplier;
  List<CountryEntity> countries = [];
  List<SupplierEntity> suppliers = [];
  List<SupplierEntity> selectedSuppliers = [];
  XFile? invoiceFile;
  Uint8List? imageBytesInvoiceFile;
  final List<String> typeOfShipments = ['ship_pay', 'ship_only', 'pay_only'];
  String? selectedType;
  String? numberTracking;

  final TextEditingController declaredParcelsCountController =
      TextEditingController();
  final TextEditingController notesController = TextEditingController();
  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? selectedImage = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (selectedImage != null) {
      final Uint8List bytes = await selectedImage.readAsBytes();
      setState(() {
        invoiceFile = selectedImage;
        imageBytesInvoiceFile = bytes;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // تحميل البيانات اللازمة
    context.read<GetUsersCubit>().getUser();
    context.read<GetCountriesCubit>().getCountries();
    context.read<GetSuppliersCubit>().getSuppliers();
  }

  @override
  void dispose() {
    declaredParcelsCountController.dispose();
    notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // الصورة ثابتة، وباقي الصفحة تسكرول
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 70.w),
        child: Column(
          children: [
            // الصورة (ثابتة)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Flexible(
                  child: SvgPicture.asset(AssetsData.ballon, width: 30.w),
                ),
              ],
            ),

            // باقي المحتوى قابل للسكرول
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                children: [
                  // ===== العملاء =====
                  BlocBuilder<GetUsersCubit, GetUsersState>(
                    builder: (context, state) {
                      List<UserEntity> users = [];
                      if (state is GetUsersSuccess) {
                        users = state.users;
                      }
                      return GenericDropdownField<UserEntity>(
                        items: users,
                        selectedItem: selectedCustomer,
                        onChanged:
                            (value) => setState(() => selectedCustomer = value),
                        itemAsString: (c) => c.firstName,
                        hintText: 'اسم العميل',
                        svgIcon: SvgPicture.asset(
                          AssetsData.person,
                          height: 20.h,
                        ),
                        validator:
                            (value) =>
                                value == null ? 'الرجاء اختيار العميل' : null,
                      );
                    },
                  ),

                  SizedBox(height: 20.h),

                  // ===== البلدان =====
                  BlocBuilder<GetCountriesCubit, GetCountriesState>(
                    builder: (context, state) {
                      if (state is GetCountriesSuccess) {
                        countries = state.countries;
                      }
                      return GenericDropdownField<CountryEntity>(
                        items: countries,
                        selectedItem: selectedOriginCountry,
                        onChanged:
                            (value) =>
                                setState(() => selectedOriginCountry = value),
                        itemAsString: (c) => c.name,
                        hintText: 'البلد المصدر',
                        svgIcon: SvgPicture.asset(
                          AssetsData.bulb,
                          height: 20.h,
                        ),
                        validator:
                            (value) =>
                                value == null
                                    ? 'الرجاء اختيار البلد المصدر'
                                    : null,
                      );
                    },
                  ),

                  SizedBox(height: 20.h),

                  GenericDropdownField<CountryEntity>(
                    items: countries,
                    selectedItem: selectedDestinitionCountry,
                    onChanged:
                        (value) =>
                            setState(() => selectedDestinitionCountry = value),
                    itemAsString: (c) => c.name,
                    hintText: 'البلد الوجهة',
                    svgIcon: SvgPicture.asset(AssetsData.bulb, height: 20.h),
                    validator:
                        (value) =>
                            value == null ? 'الرجاء اختيار البلد الوجهة' : null,
                  ),

                  SizedBox(height: 20.h),

                  // ===== نوع الشحنة =====
                  GenericDropdownField<String>(
                    items: typeOfShipments,
                    selectedItem: selectedType,
                    onChanged: (value) {
                      setState(() {
                        selectedType = value;
                        if (isPayOnly) {
                          // امسح عدد الطرود عند الدفع فقط
                          declaredParcelsCountController.clear();
                        }
                      });
                    },
                    itemAsString: (c) => c,
                    hintText: 'نوع الشحنة',
                    svgIcon: SvgPicture.asset(
                      AssetsData.outlinePurpleBox,
                      height: 20.h,
                    ),
                    validator:
                        (value) =>
                            value == null ? 'الرجاء اختيار نوع الشحنة' : null,
                  ),

                  SizedBox(height: 20.h),

                  // ===== المزوّد =====
                  BlocBuilder<GetSuppliersCubit, GetSuppliersState>(
                    builder: (context, state) {
                      if (state is GetSuppliersSuccess) {
                        suppliers = state.suppliers;
                      }

                      final selectedNames = selectedSuppliers
                          .map((e) => e.supplierName)
                          .join(', ');

                      // لإظهار رسالة خطأ إن لم يختر المستخدم مورّدين
                      final suppliersError =
                          (_formKey.currentState == null)
                              ? null
                              : (selectedSuppliers.isEmpty
                                  ? 'الرجاء اختيار المزودين'
                                  : null);

                      return MultiSelectField<SupplierEntity>(
                        hintText: 'المزودون',
                        svgIcon: SvgPicture.asset(
                          AssetsData.bulb,
                          height: 20.h,
                        ),
                        selectedItemsText: selectedNames,
                        errorText: suppliersError,
                        onTap: () async {
                          final results =
                              await showMultiSelectDialog<SupplierEntity>(
                                context: context,
                                items: suppliers,
                                initiallySelected: selectedSuppliers,
                                equals: (a, b) => a.supplierId == b.supplierId,
                                labelOf: (x) => x.supplierName,
                                title: 'اختر المزودين',
                              );
                          if (results != null) {
                            setState(() => selectedSuppliers = results);
                          }
                        },
                      );
                    },
                  ),

                  SizedBox(height: 20.h),

                  // ===== عدد الطرود =====
                  if (!isPayOnly) ...[
                    CustomInputField(
                      controller: declaredParcelsCountController,
                      hintText: 'عدد الطرود',
                      svgPicture: SvgPicture.asset(
                        AssetsData.boxNotFilled,
                        height: 15.h,
                      ),
                      validator: (value) {
                        if (isPayOnly) return null; // لا نتحقق عند الدفع فقط
                        if (value == null || value.isEmpty)
                          return 'يرجى إدخال عدد الطرود';
                        // (اختياري) تحقق أنه رقم صحيح
                        final n = int.tryParse(value);
                        if (n == null || n < 0) return 'يرجى إدخال رقم صحيح';
                        return null;
                      },
                    ),
                    SizedBox(height: 20.h),
                  ],

                  // ===== ملاحظات =====
                  CustomInputField(
                    controller: notesController,
                    hintText: 'ملاحظات',
                    svgPicture: SvgPicture.asset(
                      AssetsData.notesIcon,
                      height: 15.h,
                    ),
                  ),

                  SizedBox(height: 20.h),
                  SizedBox(
                    width: 15.w,
                    child: UploadImage(
                      label: 'أدخل صورة الفاتورة',
                      onTap: () => pickImage(),
                      imageBytes: imageBytesInvoiceFile,
                    ),
                  ),
                  SizedBox(height: 20.h),

                  // ===== زر إنشاء الشحنة =====
                  BlocConsumer<CreateShipmentCubit, CreateShipmentState>(
                    listener: (context, state) {
                      if (state is CreateShipmentSuccess) {
                        showToastMsg(context, "تم انشاء الشحنة بنجاح");

                        setState(() {
                          selectedCustomer = null;
                          selectedOriginCountry = null;
                          selectedDestinitionCountry = null;
                          selectedType = null;
                          selectedSupplier = null;
                        });

                        declaredParcelsCountController.clear();
                        notesController.clear();
                        _formKey.currentState?.reset();
                      } else if (state is CreateShipmentFailure) {
                        showToastMsg(context, state.message);
                      }
                    },
                    builder: (context, state) {
                      return MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () {
                            if (invoiceFile == null) return;
                            if (_formKey.currentState!.validate()) {
                              context
                                  .read<CreateShipmentCubit>()
                                  .createShipment(
                                    type: selectedType!,
                                    customerId: selectedCustomer!.id,
                                    declaredParcelsCount:
                                        isPayOnly
                                            ? null
                                            : declaredParcelsCountController
                                                .text,
                                    notes: notesController.text,
                                    destenationCountryId:
                                        selectedDestinitionCountry!.id,
                                    originCountryId: selectedOriginCountry!.id,
                                    supplierIds:
                                        selectedSuppliers
                                            .map((e) => e.supplierId)
                                            .toList(),
                                    invoiceFile: invoiceFile!,
                                  );
                            }
                          },

                          child:
                              state is CreateShipmentLoading
                                  ? const CustomProgressIndicator()
                                  : Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 60.w,
                                    ),
                                    child: Container(
                                      height: 40.h,
                                      decoration: BoxDecoration(
                                        color: AppColors.goldenYellow,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          width: 1,
                                          color: AppColors.deepPurple,
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'موافق',
                                          style: Styles.textStyle4Sp.copyWith(
                                            color: AppColors.black.withValues(
                                              alpha: 0.4,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                        ),
                      );
                    },
                  ),

                  SizedBox(height: 20.h),

                  // ===== بطاقة رقم التتبع (إن وُجد) =====
                  if (numberTracking != null)
                    TrackNumberCard(number: '$numberTracking'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
