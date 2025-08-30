import 'dart:typed_data';

import 'package:final_subul_project/core/helpers/extensions.dart';
import 'package:final_subul_project/core/routing/routes.dart';
import 'package:final_subul_project/core/utils/functions/show_snack_bar.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/use_case/get_flights_use_case/get_flights_use_case.dart';
import 'package:final_subul_project/features/get_shipment_in_process/presentation/manager/get_flights_cubit/get_flights_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:final_subul_project/core/helpers/assets_data.dart';
import 'package:final_subul_project/core/helpers/constants.dart';
import 'package:final_subul_project/core/helpers/styles.dart';
import 'package:final_subul_project/core/theming/app_colors.dart';
import 'package:final_subul_project/core/utils/service_locator.dart';
import 'package:final_subul_project/core/widgets/custom_ok_button.dart';
import 'package:final_subul_project/core/widgets/custom_progress_indicator.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/use_case/get_drivers_use_case/get_drivers_use_case.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/use_case/update_shipment_for_delivery_use_case/update_shipment_for_delivery_use_case.dart';
import 'package:final_subul_project/features/get_shipment_in_process/presentation/manager/get_drivers_cubit/get_drivers_cubit.dart';
import 'package:final_subul_project/features/get_shipment_in_process/presentation/manager/update_shipment_for_delivery_cubit/update_shipment_for_delivery_cubit.dart';

class UploadNumberImageAndNameOfDriverShipment extends StatefulWidget {
  final int shipmentId;
  final int createdParcelsNumber;
  const UploadNumberImageAndNameOfDriverShipment({
    super.key,
    required this.shipmentId,
    required this.createdParcelsNumber,
  });

  @override
  State<UploadNumberImageAndNameOfDriverShipment> createState() =>
      _UploadNumberImageAndNameOfDriverShipmentState();
}

class _UploadNumberImageAndNameOfDriverShipmentState
    extends State<UploadNumberImageAndNameOfDriverShipment> {
  int? selectedIdDelivery;
  int? selectedFlightId;

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

  String _fmtHM(DateTime dt) {
    String two(n) => n.toString().padLeft(2, '0');
    return '${two(dt.hour)}:${two(dt.minute)}';
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) =>
                  GetDriversCubit(sl.get<GetDriversUseCase>())..getDrivers(),
        ),
        BlocProvider(
          create:
              (_) => GetFlightsCubit(sl.get<GetFlightsUseCase>())..getFlights(),
        ),
        BlocProvider(
          create:
              (context) => UpdateShipmentForDeliveryCubit(
                sl.get<UpdateShipmentForDeliveryUseCase>(),
              ),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(automaticallyImplyLeading: true),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          child: Center(
            child: SingleChildScrollView(
              child: BlocConsumer<
                UpdateShipmentForDeliveryCubit,
                UpdateShipmentForDeliveryState
              >(
                listener: (context, state) {
                  if (state is UpdateShipmentForDeliveryFailure) {
                    showToastMsg(context, state.message);
                  } else if (state is UpdateShipmentForDeliverySuccess) {
                    showToastMsg(context, "تم التحديث بنجاح");
                    context.pushNamed(
                      Routes.shipmentReceipt,
                      arguments: widget.shipmentId,
                    );
                  }
                },
                builder: (context, state) {
                  return Container(
                    width: 120.w,
                    height: 800.h,
                    padding: EdgeInsets.symmetric(
                      horizontal: 6.w,
                      vertical: 15.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.lightGray2,
                      borderRadius: BorderRadius.circular(cornerRadius),
                      border: Border.all(
                        width: 1,
                        color: AppColors.goldenYellow,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // CardTextField(
                        //   svgPicture: SvgPicture.asset(
                        //     AssetsData.outlinePurpleBox,
                        //   ),
                        //   hintText: 'عدد الطرود',
                        //   controller: countOfParcels,
                        // ),
                        BlocBuilder<GetFlightsCubit, GetFlightsState>(
                          builder: (context, fState) {
                            if (fState is GetFlightsLoading) {
                              return const Padding(
                                padding: EdgeInsets.all(12.0),
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (fState is GetFlightsFailure) {
                              return _DropdownCard(
                                child: const Padding(
                                  padding: EdgeInsets.all(12.0),
                                  child: Text('تعذّر تحميل الرحلات'),
                                ),
                              );
                            }
                            if (fState is GetFlightsSuccess) {
                              final flights = fState.flights;
                              if (flights.isEmpty) {
                                return _DropdownCard(
                                  child: const Padding(
                                    padding: EdgeInsets.all(12.0),
                                    child: Text('لا توجد رحلات متاحة'),
                                  ),
                                );
                              }

                              return _DropdownCard(
                                child: SizedBox(
                                  width: double.infinity,
                                  child: DropdownButtonFormField<int>(
                                    value: selectedFlightId,
                                    isExpanded: true,
                                    isDense: false, // ↑ زر أعلى قليلًا
                                    itemHeight:
                                        null, // ↑ عناصر القائمة تسمح بأكثر من سطر
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                    hint: Text(
                                      'اختر الرحلة',
                                      style: Styles.textStyle3Sp.copyWith(
                                        color: Colors.grey,
                                      ),
                                    ),

                                    // ماذا يُعرض داخل الزر بعد الاختيار (سطر واحد مضغوط)
                                    selectedItemBuilder: (ctx) {
                                      return flights.map((f) {
                                        final routeText =
                                            '${f.departureAirport!.code} ${_fmtHM(f.departureTime)} → '
                                            '${f.arrivalAirport!.code} ${_fmtHM(f.arrivalTime)}';
                                        return Row(
                                          children: [
                                            const Icon(
                                              Icons.flight_takeoff,
                                              color: AppColors.deepPurple,
                                              size: 18,
                                            ),
                                            const SizedBox(width: 8),
                                            Expanded(
                                              child: Text(
                                                '${f.flightNumber}  •  $routeText',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: Styles.textStyle4Sp,
                                              ),
                                            ),
                                          ],
                                        );
                                      }).toList();
                                    },

                                    // عناصر القائمة (سطرين بشكل جميل)
                                    items:
                                        flights.map((f) {
                                          final routeText =
                                              '${f.departureAirport!.code} ${_fmtHM(f.departureTime)} → '
                                              '${f.arrivalAirport!.code} ${_fmtHM(f.arrivalTime)}';
                                          return DropdownMenuItem<int>(
                                            value: f.id,
                                            child: Row(
                                              mainAxisSize:
                                                  MainAxisSize
                                                      .min, // لا توسّع بلا حدود
                                              children: [
                                                const Icon(
                                                  Icons.flight_takeoff,
                                                  color: AppColors.deepPurple,
                                                  size: 18,
                                                ),
                                                const SizedBox(width: 8),
                                                Flexible(
                                                  // بدل Expanded داخل قائمة
                                                  fit: FlexFit.loose,
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        f.flightNumber,
                                                        style: Styles
                                                            .textStyle4Sp
                                                            .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                            ),
                                                        overflow:
                                                            TextOverflow
                                                                .ellipsis,
                                                        maxLines: 1,
                                                      ),
                                                      const SizedBox(height: 2),
                                                      Text(
                                                        routeText,
                                                        style: Styles
                                                            .textStyle3Sp
                                                            .copyWith(
                                                              color:
                                                                  AppColors
                                                                      .mediumGray,
                                                            ),
                                                        overflow:
                                                            TextOverflow
                                                                .ellipsis,
                                                        maxLines: 1,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        }).toList(),

                                    onChanged:
                                        (v) => setState(
                                          () => selectedFlightId = v,
                                        ),
                                  ),
                                ),
                              );
                            }
                            return const SizedBox.shrink();
                          },
                        ),

                        SizedBox(height: size.height / 25),
                        BlocBuilder<GetDriversCubit, GetDriversState>(
                          builder: (context, state) {
                            if (state is GetDriversLoading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (state is GetDriversFailure) {
                              return Text(
                                'فشل في تحميل السائقين: //${state.message}',
                              );
                            } else if (state is GetDriversSuccess) {
                              return Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 4.w,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12.r),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 4,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: DropdownButtonFormField<int>(
                                    value: selectedIdDelivery,
                                    isDense: true,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      icon: SvgPicture.asset(
                                        AssetsData.personName,
                                      ),
                                    ),
                                    hint: Text(
                                      'اسم السائق',
                                      style: Styles.textStyle3Sp.copyWith(
                                        color: Colors.grey,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    items:
                                        state.drivers.map((driver) {
                                          return DropdownMenuItem<int>(
                                            value: driver.idDriver,
                                            child: Text(
                                              driver.nameDriver,
                                              style: Styles.textStyle4Sp,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          );
                                        }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        selectedIdDelivery = value;
                                      });
                                    },
                                  ),
                                ),
                              );
                            } else {
                              return const SizedBox(); // في حالة initial
                            }
                          },
                        ),

                        SizedBox(height: size.height / 20),
                        InkWell(
                          onTap: pickImage,
                          child: Container(
                            width: 65.w,
                            height: 120.h,
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            alignment: Alignment.topCenter,
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 3,
                                  // spreadRadius: 1,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child:
                                imageBytes != null
                                    ? Image.memory(
                                      imageBytes!,
                                      fit: BoxFit.cover,
                                    )
                                    : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            'ارفع صورة الشحنة',
                                            textAlign: TextAlign.center,
                                            maxLines: 1,
                                            overflow: TextOverflow.clip,
                                            style: Styles.textStyle4Sp,
                                          ),
                                        ),
                                        Flexible(
                                          child: Icon(
                                            Icons.camera_enhance_outlined,
                                            color: AppColors.deepPurple,
                                          ),
                                        ),
                                      ],
                                    ),
                          ),
                        ),
                        SizedBox(height: size.height / 20),
                        state is UpdateShipmentForDeliveryLoading
                            ? CustomProgressIndicator()
                            : CustomOkButton(
                              onTap: () {
                                if (pickedImage == null) {
                                  showToastMsg(context, "ارفع صورة الشحنة");
                                  return;
                                }
                                if (selectedIdDelivery == null) {
                                  showToastMsg(context, "اختر السائق");
                                  return;
                                }
                                context
                                    .read<UpdateShipmentForDeliveryCubit>()
                                    .updateShipment(
                                      photo: pickedImage!,
                                      idDelivery: selectedIdDelivery!,
                                      actualParcelsCount:
                                          widget.createdParcelsNumber,
                                      idShipment: widget.shipmentId,
                                      flightId: selectedFlightId!,
                                    );
                              },
                              color: AppColors.goldenYellow,
                              label: 'موافق',
                            ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DropdownCard extends StatelessWidget {
  const _DropdownCard({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: child,
    );
  }
}
