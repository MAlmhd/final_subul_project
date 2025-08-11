import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:final_subul_project/core/helpers/assets_data.dart';
import 'package:final_subul_project/core/helpers/extensions.dart';
import 'package:final_subul_project/core/helpers/styles.dart';
import 'package:final_subul_project/core/theming/app_colors.dart';
import 'package:final_subul_project/core/widgets/custom_progress_indicator.dart';
import 'package:final_subul_project/features/create_shipment/domain/entities/country_entity/country_entity.dart';
import 'package:final_subul_project/features/create_shipment/presentation/manager/get_countries_cubit/get_countries_cubit.dart';
import 'package:final_subul_project/features/get_shipment_in_process/presentation/manager/update_shipment_destenation_country_cubit/update_shipment_destenation_country_cubit.dart';
import 'package:final_subul_project/features/get_shipment_in_process/presentation/manager/update_shipment_origin_country_cubit/update_shipment_origin_country_cubit.dart';
import 'package:final_subul_project/features/warehouse_manager/ui/widgets/generic_dropdown_field.dart';

class CountrySwitchContainer extends StatefulWidget {
  const CountrySwitchContainer({super.key, required this.idShipment});
  final int idShipment;

  @override
  State<CountrySwitchContainer> createState() => _CountrySwitchContainerState();
}

class _CountrySwitchContainerState extends State<CountrySwitchContainer> {
  List<CountryEntity> countries = [];

  CountryEntity? selectedOriginCountry;
  CountryEntity? selectedDestinitionCountry;

  @override
  void initState() {
    context.read<GetCountriesCubit>().getCountries();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return MultiBlocListener(
      listeners: [
        BlocListener<
          UpdateShipmentOriginCountryCubit,
          UpdateShipmentOriginCountryState
        >(
          listener: (context, state) {
            if (state is UpdateShipmentOriginCountryFailure) {
              Fluttertoast.showToast(
                msg: state.message,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                backgroundColor: Colors.black87,
                textColor: Colors.white,
                fontSize: 16.0,
              );
            }
            if (state is UpdateShipmentOriginCountrySuccess) {
              Fluttertoast.showToast(
                msg: "تم التحديث بنجاح",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                backgroundColor: Colors.black87,
                textColor: Colors.white,
                fontSize: 16.0,
              );
            }
          },
        ),
        BlocListener<
          UpdateShipmentDestenationCountryCubit,
          UpdateShipmentDestenationCountryState
        >(
          listener: (context, state) {
            if (state is UpdateShipmentDestenationCountryFailure) {
              Fluttertoast.showToast(
                msg: state.message,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                backgroundColor: Colors.black87,
                textColor: Colors.white,
                fontSize: 16.0,
              );
            }
            if (state is UpdateShipmentDestenationCountrySuccess) {
              Fluttertoast.showToast(
                msg: "تم التحديث بنجاح",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                backgroundColor: Colors.black87,
                textColor: Colors.white,
                fontSize: 16.0,
              );
            }
            if (state is UpdateShipmentDestenationCountrySuccess ||
                state is UpdateShipmentOriginCountrySuccess) {
              context.pop();
            }
          },
        ),
      ],
      child: Scaffold(
        body: Center(
          child: Container(
            width: 200.w,
            height: 500.h,
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: AppColors.lightGray2,
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                BlocBuilder<GetCountriesCubit, GetCountriesState>(
                  builder: (context, state) {
                    if (state is GetCountriesSuccess) {
                      countries = state.countries;
                    }

                    return Column(
                      children: [
                        GenericDropdownField<CountryEntity>(
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
                        ),
                        SizedBox(height: 15.h),

                        GenericDropdownField<CountryEntity>(
                          items: countries,
                          selectedItem: selectedDestinitionCountry,
                          onChanged:
                              (value) => setState(
                                () => selectedDestinitionCountry = value,
                              ),
                          itemAsString: (c) => c.name,
                          hintText: 'البلد الوجهة',
                          svgIcon: SvgPicture.asset(
                            AssetsData.bulb,
                            height: 20.h,
                          ),
                          validator:
                              (value) =>
                                  value == null
                                      ? 'الرجاء اختيار البلد الوجهة'
                                      : null,
                        ),
                        SizedBox(height: size.height / 40),
                        state is UpdateShipmentDestenationCountryLoading ||
                                state is UpdateShipmentOriginCountryLoading
                            ? CustomProgressIndicator()
                            : Center(
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {});

                                  context
                                      .read<UpdateShipmentOriginCountryCubit>()
                                      .updateCountry(
                                        idShipment: widget.idShipment,
                                        idCountry: selectedOriginCountry!.id,
                                      );

                                  context
                                      .read<
                                        UpdateShipmentDestenationCountryCubit
                                      >()
                                      .updateCountry(
                                        idShipment: widget.idShipment,
                                        idCountry:
                                            selectedDestinitionCountry!.id,
                                      );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.goldenYellow,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                ),
                                child: Text(
                                  'حفظ',
                                  style: Styles.textStyle5Sp.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                      ],
                    );
                  },
                ),

                // Text('البلد الوجهة', style: Styles.textStyle5Sp.copyWith(fontWeight: FontWeight.bold)),
                // SwitchListTile(
                //   title: Text(isDestinationUAE ? 'الإمارات 🇦🇪' : 'تركيا 🇹🇷', style: Styles.textStyle5Sp),
                //   value: isDestinationUAE,
                //   onChanged: (value) {
                //     setState(() {
                //       isDestinationUAE = value;
                //     });
                //   },
                //   activeColor: AppColors.goldenYellow,
                //   contentPadding: EdgeInsets.zero,
                // ),
                // SizedBox(height: 20.h),

                // Text('البلد المصدر', style: Styles.textStyle5Sp.copyWith(fontWeight: FontWeight.bold)),
                // SwitchListTile(
                //   title: Text(isOriginUAE ? 'الإمارات 🇦🇪' : 'تركيا 🇹🇷', style: Styles.textStyle5Sp),
                //   value: isOriginUAE,
                //   onChanged: (value) {
                //     setState(() {
                //       isOriginUAE = value;
                //     });
                //   },
                //   activeColor: AppColors.goldenYellow,
                //   contentPadding: EdgeInsets.zero,
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
