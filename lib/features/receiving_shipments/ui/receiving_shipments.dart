import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:final_subul_project/core/helpers/assets_data.dart';
import 'package:final_subul_project/core/theming/app_colors.dart';
import 'package:final_subul_project/core/widgets/custom_icon_of_side_bar.dart';
import 'package:final_subul_project/core/widgets/text_logo.dart';
import 'package:final_subul_project/features/receiving_shipments/ui/widgets/custom_error_widget.dart';

class ReceivingShipments extends StatelessWidget {
  const ReceivingShipments({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
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
          child: Row(
            children: [
              Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10.w, top: 40.h),
                        child: TextLogo(),
                      ),
                      SizedBox(height: size.height / 10),
                      Container(
                        width: 20.w,
                        height: 900.h,
                        decoration: BoxDecoration(
                          color: AppColors.goldenYellow,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(120),
                            topLeft: Radius.circular(10),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomIconOfSideBar(
                              icon: Icons.local_shipping,
                              color: AppColors.white,
                              onTap: () {},
                              isSelected: false,
                            ),
                            SizedBox(height: size.height / 10),
                            CustomIconOfSideBar(
                              image: AssetsData.boxShipmmentIcon,
                              onTap: () {},
                              isSelected: false,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Expanded(
                child: IndexedStack(
                  index: 0,
                  children: [
                    //ReceiveShipmentsTable(),
                    // EditReceivingShipmentsTable(),
                    // TimeDateBooking(),
                    //  ConfirmOrFailedReceiveShipment(),
                    // ReceivedDialog(),
                    // EnterDetailsOfShipments(),
                    // CustomCalendar(
                    //   onTap: () {
                    //     showTimePicker(
                    //       context: context,
                    //       initialTime: TimeOfDay.now(),
                    //     );
                    //   },
                    // ),
                    // ShowShipmentsDelivered()
                    // SingleChildScrollView(
                    //   scrollDirection: Axis.horizontal,
                    //   child: Row(
                    //     children: [
                    //       //GridOfShipmentsStatusCard(),
                    //       EditInformationOfReceivingShipments(),
                    //       ListForSelectingShipmentsReceiving(),
                    //     ],
                    //   ),
                    // ),

                    //  ReceivedDialog(message: 'هنيئاً ... الآن نحتاج لملئ استمارة تثبيت الاستلام ',),
                    CustomErrorWidget(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
