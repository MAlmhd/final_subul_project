import 'package:final_subul_project/core/helpers/extensions.dart';
import 'package:final_subul_project/core/utils/functions/show_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:final_subul_project/core/helpers/assets_data.dart';
import 'package:final_subul_project/core/helpers/constants.dart';
import 'package:final_subul_project/core/helpers/styles.dart';
import 'package:final_subul_project/core/routing/routes.dart';
import 'package:final_subul_project/core/theming/app_colors.dart';
import 'package:final_subul_project/core/utils/service_locator.dart';
import 'package:final_subul_project/core/widgets/custom_progress_indicator.dart';
import 'package:final_subul_project/features/track_shipments_home/domain/use_case/get_invoices_use_case/get_invoice_use_case.dart';
import 'package:final_subul_project/features/track_shipments_home/presentation/manager/get_invoices_cubit/get_invoices_cubit.dart';

class DetailsOfBill extends StatelessWidget {
  final int id;
  const DetailsOfBill({super.key, required this.id});

  String _dashIfNull(dynamic v) => (v == null || (v is String && v.trim().isEmpty)) ? '-' : '$v';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetInvoicesCubit(sl.get<GetInvoiceUseCase>())..getInvoice(id: id),
      child: Scaffold(
        backgroundColor: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFF8F9FB), Color(0xFFF1F3F6)],
        ).createShader(const Rect.fromLTWH(0, 0, 1, 1)) == null
            ? AppColors.white2
            : AppColors.white2, // الخلفية الفاتحة
        body: SafeArea(
          child: Center(
            child: BlocConsumer<GetInvoicesCubit, GetInvoicesState>(
              listener: (context, state) {
                if (state is GetInvoicesFailure) {
                  showToastMsg(context, state.message);
                }
              },
              builder: (context, state) {
                if (state is GetInvoicesLoading) return const CustomProgressIndicator();

                if (state is! GetInvoicesSuccess) return const SizedBox.shrink();

                if (state.invoice.success == false) {
                  return Text('لا توجد فاتورة', style: Styles.textStyle7Sp);
                }

                final inv = state.invoice;

                return SingleChildScrollView(
                  padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 360.w),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 18.h),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(cornerRadius + 6),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 22,
                            spreadRadius: 2,
                            offset: Offset(0, 14),
                          )
                        ],
                        border: Border.all(color: AppColors.lightGray, width: 1),
                      ),
                      child: LayoutBuilder(
                        builder: (ctx, constraints) {
                          final isWide = constraints.maxWidth > 220.w;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // Header
                              Row(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: AppColors.deepPurple.withOpacity(.1),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const Icon(Icons.receipt_long, color: Color(0xFF4C3BCF)),
                                  ),
                                  SizedBox(width: 12.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text('تفاصيل الفاتورة', style: Styles.textStyle6Sp),
                                        SizedBox(height: 4.h),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            _Chip(label: 'رقم الفاتورة: ${_dashIfNull(inv.invoiceNumber)}'),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 18.h),

                              // QR + basic box on left, info grid on right (responsive)
                              Flex(
                                direction: isWide ? Axis.horizontal : Axis.vertical,
                                crossAxisAlignment:
                                    isWide ? CrossAxisAlignment.start : CrossAxisAlignment.stretch,
                                children: [
                                  // Left column (QR + supplier + parcels)
                                  Expanded(
                                    flex: isWide ? 1 : 0,
                                    child: Column(
                                      children: [
                                        _SectionCard(
                                          title: 'كود الاستلام',
                                          child: Column(
                                            children: [
                                              // QR
                                              if ((inv.qrCode ?? '').isNotEmpty)
                                                Padding(
                                                  padding: EdgeInsets.only(bottom: 12.h),
                                                  child: Center(
                                                    child: SvgPicture.network(
                                                      inv.qrCode,
                                                      width: 90.w,
                                                      placeholderBuilder: (context) =>
                                                          const CircularProgressIndicator(),
                                                    ),
                                                  ),
                                                ),
                                              // parcels count pill
                                              _InfoPill(
                                                icon: AssetsData.purbleBox,
                                                text: '${_dashIfNull(inv.declaredParcelsCount)} طرود',
                                              ),
                                              SizedBox(height: 10.h),
                                              _InfoRow(
                                                icon: Icons.person_outline,
                                                label: 'اسم المورد',
                                                value: _dashIfNull(inv.supplierName),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  SizedBox(width: isWide ? 16.w : 0, height: isWide ? 0 : 16.h),

                                  // Right column: grid of info
                                  Expanded(
                                    flex: isWide ? 1 : 0,
                                    child: _SectionCard(
                                      title: 'معلومات الدفع و العميل',
                                      child: Wrap(
                                        runSpacing: 10.h,
                                        spacing: 10.w,
                                        children: [
                                          _InfoTile(
                                            icon: Icons.event_available,
                                            label: 'موعد التسليم',
                                            value: _dashIfNull(inv.payableAt),
                                          ),
                                          _InfoTile(
                                            icon: Icons.attach_money,
                                            label: 'قيمة الفاتورة',
                                            value: _dashIfNull('${inv.amount} \$'),
                                          ),
                                          _InfoTile(
                                            icon: Icons.badge_outlined,
                                            label: 'رمز الزبون',
                                            value: _dashIfNull(inv.customerCode),
                                          ),
                                          _InfoTile(
                                            icon: Icons.person,
                                            label: 'اسم العميل',
                                            value: _dashIfNull(inv.name),
                                          ),
                                          _InfoTile(
                                            icon: Icons.phone_outlined,
                                            label: 'رقم العميل',
                                            value: _dashIfNull(inv.phone),
                                          ),
                                          _InfoTile(
                                            icon: Icons.percent,
                                            label: 'الضريبة',
                                            value: _dashIfNull(inv.taxAmount),
                                          ),
                                          _InfoTile(
                                            icon: Icons.payments_outlined,
                                            label: 'المبلغ الكلي',
                                            value: _dashIfNull(inv.totalAmount),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: 18.h),

                              // Actions
                              Row(
                                children: [
                                  Expanded(
                                    child: OutlinedButton.icon(
                                      onPressed: () => context.pushNamedAndRemoveUntil(Routes.homeView, predicate: (route) => false,),
                                      icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 16),
                                      label: Text('رجوع', style: Styles.textStyle4Sp),
                                      style: OutlinedButton.styleFrom(
                                        side: BorderSide(color: AppColors.deepPurple, width: 1),
                                        foregroundColor: AppColors.deepPurple,
                                        padding: EdgeInsets.symmetric(vertical: 12.h),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10.w),
                                  Expanded(
                                    child: ElevatedButton.icon(
                                      onPressed: () {
                                        // مكان زر إضافي (تحميل PDF مستقبلاً)
                                        showToastMsg(context, 'تم');
                                      },
                                      icon: const Icon(Icons.download_rounded, size: 18),
                                      label: Text('حفظ/طباعة', style: Styles.textStyle4Sp.copyWith(color: Colors.white)),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.deepPurple,
                                        padding: EdgeInsets.symmetric(vertical: 12.h),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      ),
                    ),
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

/// بطاقة قسم بعنوان + جسم
class _SectionCard extends StatelessWidget {
  final String title;
  final Widget child;
  const _SectionCard({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.lightGray, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(title, style: Styles.textStyle5Sp),
          SizedBox(height: 10.h),
          child,
        ],
      ),
    );
  }
}

/// عنصر معلومة بشكل “タيل” موحّد
class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _InfoTile({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150.w,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.white2,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.lightGray, width: 1),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.deepPurple, size: 18),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(label, style: Styles.textStyle3Sp.copyWith(color: Colors.black54)),
                SizedBox(height: 4.h),
                Text(
                  value,
                  style: Styles.textStyle4Sp,
                  textAlign: TextAlign.right,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// صف معلومة بسيط أيقونة + نصين
class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _InfoRow({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.white2,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.lightGray, width: 1),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.deepPurple, size: 18),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              '$label : $value',
              style: Styles.textStyle4Sp,
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

/// “حبة” لطيفة (pill) مع SVG يسار
class _InfoPill extends StatelessWidget {
  final String text;
  final String icon;
  const _InfoPill({required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        color: AppColors.goldenYellow,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.deepGray, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(icon, width: 16.w),
          SizedBox(width: 8.w),
          Text(text, style: Styles.textStyle4Sp),
        ],
      ),
    );
  }
}

/// شارة صغيرة للهيدر
class _Chip extends StatelessWidget {
  final String label;
  const _Chip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: AppColors.white2,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.lightGray, width: 1),
      ),
      child: Text(label, style: Styles.textStyle3Sp),
    );
  }
}
