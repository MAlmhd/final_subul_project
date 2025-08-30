import 'package:final_subul_project/core/utils/functions/show_snack_bar.dart';
import 'package:final_subul_project/features/get_unapproved_shipments/domain/entities/un_approved_shipment_entity/un_approved_shipments_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:final_subul_project/core/helpers/constants.dart';
import 'package:final_subul_project/core/helpers/extensions.dart';
import 'package:final_subul_project/core/helpers/styles.dart';
import 'package:final_subul_project/core/routing/routes.dart';
import 'package:final_subul_project/core/theming/app_colors.dart';
import 'package:final_subul_project/core/utils/service_locator.dart';
import 'package:final_subul_project/core/widgets/custom_progress_indicator.dart';
import 'package:final_subul_project/features/track_shipments_home/domain/use_case/create_invoice_use_case/create_invoice_use_case.dart';
import 'package:final_subul_project/features/track_shipments_home/presentation/manager/create_invoice_cubit/create_invoice_cubit.dart';
import 'package:final_subul_project/features/track_shipments_home/presentation/views/widgets/square_price.dart';

class PayTheBillOfUnApprovedShipment extends StatefulWidget {
  const PayTheBillOfUnApprovedShipment({super.key, this.unApprovedShipmentsEntity});
  final UnApprovedShipmentsEntity? unApprovedShipmentsEntity;

  @override
  State<PayTheBillOfUnApprovedShipment> createState() => _PayTheBillOfUnApprovedShipmentState();
}

class _PayTheBillOfUnApprovedShipmentState extends State<PayTheBillOfUnApprovedShipment> {
  late DateTime date; // تاريخ اليوم تلقائيًا
  final TextEditingController priceController = TextEditingController();
  int selectedPrice = 100;

  String _formatYMD(DateTime d) {
    String two(int n) => n.toString().padLeft(2, '0');
    return '${d.year}-${two(d.month)}-${two(d.day)}';
  }

  void selectPrice(int price) {
    setState(() {
      selectedPrice = price;
      priceController.text = price.toString();
    });
  }

  bool get _showPriceSection {
    final t = widget.unApprovedShipmentsEntity?.typeOfShipment;
    return t == 'ship_pay' || t == 'pay_only';
  }

  @override
  void initState() {
    super.initState();
    date = DateTime.now();               // ✅ اليوم تلقائيًا
    selectedPrice = 100;
    priceController.text = selectedPrice.toString();
  }

  @override
  void dispose() {
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: BlocProvider(
          create: (context) => CreateInvoiceCubit(sl.get<CreateInvoiceUseCase>()),
          child: Container(
            width: 150.w,
            height: 500.h,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(cornerRadius),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 18,
                  spreadRadius: 2,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (_showPriceSection) ...[
                  Text('أدخل المبلغ', style: Styles.textStyle6Sp, maxLines: 1),
                  Container(
                    width: double.infinity,
                    height: 45.h,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          spreadRadius: 2,
                          blurRadius: 1.3,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: TextField(
                      controller: priceController,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'أدخل مبلغ الشحن',
                        hintStyle: Styles.textStyle3Sp.copyWith(
                          color: AppColors.gunmetal,
                        ),
                        isCollapsed: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 10.h),
                      ),
                      style: Styles.textStyle3Sp,
                    ),
                  ),
                  Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    runSpacing: 10.h,
                    spacing: 10.w,
                    children: [
                      PriceSquare(price: 100, onTap: () => selectPrice(100), isSelected: selectedPrice == 100),
                      PriceSquare(price: 200, onTap: () => selectPrice(200), isSelected: selectedPrice == 200),
                      PriceSquare(price: 300, onTap: () => selectPrice(300), isSelected: selectedPrice == 300),
                      PriceSquare(price: 400, onTap: () => selectPrice(400), isSelected: selectedPrice == 400),
                    ],
                  ),
                ],

                // حقل التاريخ الذهبي (عرض فقط - تاريخ اليوم)
                Container(
                  width: double.infinity,
                  height: 50.h,
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  decoration: BoxDecoration(
                    color: AppColors.goldenYellow,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.deepGray, width: 1),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.event, size: 20), // استخدم SVG لو تحب
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Text(
                          _formatYMD(date), // yyyy-MM-dd
                          textAlign: TextAlign.right,
                          style: Styles.textStyle3Sp,
                        ),
                      ),
                      Icon(Icons.check, color: AppColors.deepPurple),
                    ],
                  ),
                ),

                // زر إنشاء الفاتورة
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: BlocConsumer<CreateInvoiceCubit, CreateInvoiceState>(
                    listener: (context, state) {
                      if (state is CreateInvoiceFailure) {
                        showToastMsg(context, state.message);
                      } else if (state is CreateInvoiceSuccess) {
                        showToastMsg(context, "تم انشاء الفاتورة بنجاح");
                        context.pushNamed(
                          Routes.detailsOfBill,
                          arguments: state.bill.id,
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is CreateInvoiceLoading) {
                        return const CustomProgressIndicator();
                      }

                      return SizedBox(
                        width: 60.w,
                        height: 40.h,
                        child: Material(
                          color: AppColors.deepPurple,
                          borderRadius: BorderRadius.circular(cornerRadius),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(cornerRadius),
                            onTap: () {
                              // تجهيز القيم
                              final priceDecimal = double.tryParse(priceController.text) ?? 0.0;
                              final formattedDate = _formatYMD(date);

                              context.read<CreateInvoiceCubit>().createInvoice(
                                customerId: widget.unApprovedShipmentsEntity!.idOfCustomer,
                                shipmentId: widget.unApprovedShipmentsEntity!.idOfShipment,
                                amount: _showPriceSection ? priceDecimal : 0.0,
                                includesTax: false,
                                payableAt: formattedDate, // تاريخ اليوم
                              );
                            },
                            child: Center(
                              child: Text(
                                'انشاء فاتورة',
                                style: Styles.textStyle3Sp.copyWith(color: AppColors.white),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
