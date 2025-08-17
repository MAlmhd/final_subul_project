// lib/features/invoice_details/presentation/pages/invoice_details_page.dart
import 'package:final_subul_project/core/utils/functions/show_snack_bar.dart';
import 'package:final_subul_project/core/widgets/custom_progress_indicator.dart';
import 'package:final_subul_project/features/get_deliverable_shipments/presentation/managers/get_invoice_details_cubit/get_invoice_details_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:final_subul_project/core/theming/app_colors.dart';
// استورد الـ Entity من الدومين لديك

class InvoiceDetailsPage extends StatefulWidget {
  const InvoiceDetailsPage({super.key, required this.shipmentId});
  final int shipmentId;

  @override
  State<InvoiceDetailsPage> createState() => _InvoiceDetailsPageState();
}

class _InvoiceDetailsPageState extends State<InvoiceDetailsPage> {
  @override
  void initState() {
    context.read<GetInvoiceDetailsCubit>().getInvoiceDetails(
      shipmentId: widget.shipmentId,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: AppColors.white2,
      body: SafeArea(
        child: BlocConsumer<GetInvoiceDetailsCubit, GetInvoiceDetailsState>(
          listener: (context, state) {
            if (state is GetInvoiceDetailsFailure) {
              showSnackBar(context, state.message, Colors.red);
            }
          },
          builder: (context, state) {
            if (state is GetInvoiceDetailsSuccess) {
              return LayoutBuilder(
                builder: (context, constraints) {
                  final bool wide = constraints.maxWidth >= 1100;
                  final bool medium = constraints.maxWidth >= 800;
                  final double maxW = 1200;
                  return Align(
                    alignment: Alignment.topCenter,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: maxW),
                      child: CustomScrollView(
                        slivers: [
                          SliverToBoxAdapter(
                            child: _Header(
                              invoiceNumber:
                                  state
                                      .entity
                                      .data
                                      .invoiceDetails
                                      .invoiceNumber,
                              status: state.entity.data.invoiceDetails.status,
                              grandTotal: state.entity.data.grandTotal,
                              currency:
                                  state.entity.data.invoiceDetails.currency,
                              onPrint: () {},
                              onDownload: () {},
                            ),
                          ),
                          SliverPadding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 16,
                            ),
                            sliver: SliverToBoxAdapter(
                              child: Flex(
                                direction:
                                    wide ? Axis.horizontal : Axis.vertical,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // العمود الأيسر: تفاصيل
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      children: [
                                        _SectionCard(
                                          title: 'تفاصيل الفاتورة',
                                          icon: Icons.receipt_long,
                                          child: _TwoColInfoGrid(
                                            items: [
                                              InfoItem(
                                                'رقم الفاتورة',
                                                state
                                                    .entity
                                                    .data
                                                    .invoiceDetails
                                                    .invoiceNumber,
                                              ),
                                              InfoItem(
                                                'الحالة',
                                                _arabicStatus(
                                                  state
                                                      .entity
                                                      .data
                                                      .invoiceDetails
                                                      .status,
                                                ),
                                              ),
                                              InfoItem(
                                                'العملة',
                                                state
                                                    .entity
                                                    .data
                                                    .invoiceDetails
                                                    .currency,
                                              ),
                                              InfoItem(
                                                'تاريخ الاستحقاق',
                                                _fmtDate(
                                                  state
                                                      .entity
                                                      .data
                                                      .invoiceDetails
                                                      .payableAt,
                                                ),
                                              ),
                                              InfoItem(
                                                'تاريخ الدفع',
                                                _fmtDateTime(
                                                  state
                                                      .entity
                                                      .data
                                                      .invoiceDetails
                                                      .paidAt,
                                                ),
                                              ),
                                              InfoItem(
                                                'طريقة الدفع',
                                                state
                                                        .entity
                                                        .data
                                                        .invoiceDetails
                                                        .paymentMethod ??
                                                    '—',
                                              ),
                                              InfoItem(
                                                'شامل ضريبة؟',
                                                state
                                                        .entity
                                                        .data
                                                        .invoiceDetails
                                                        .includesTax
                                                    ? 'نعم'
                                                    : 'لا',
                                              ),
                                              InfoItem(
                                                'سبب التعديل',
                                                state
                                                        .entity
                                                        .data
                                                        .invoiceDetails
                                                        .adjustmentReason ??
                                                    '—',
                                              ),
                                              InfoItem(
                                                'قيمة التعديل',
                                                _fmtMoneyNullable(
                                                  state
                                                      .entity
                                                      .data
                                                      .invoiceDetails
                                                      .adjustedAmount,
                                                  state
                                                      .entity
                                                      .data
                                                      .invoiceDetails
                                                      .currency,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        _SectionCard(
                                          title: 'بيانات العميل',
                                          icon: Icons.person_outline,
                                          child: _TwoColInfoGrid(
                                            items: [
                                              InfoItem(
                                                'الاسم',
                                                state
                                                    .entity
                                                    .data
                                                    .customerDetails
                                                    .name,
                                              ),
                                              InfoItem(
                                                'رمز العميل',
                                                state
                                                    .entity
                                                    .data
                                                    .customerDetails
                                                    .customerCode,
                                              ),
                                              InfoItem(
                                                'البريد',
                                                state
                                                    .entity
                                                    .data
                                                    .customerDetails
                                                    .email,
                                              ),
                                              InfoItem(
                                                'الهاتف',
                                                state
                                                    .entity
                                                    .data
                                                    .customerDetails
                                                    .phone,
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        _SectionCard(
                                          title: 'تفاصيل الشحنة',
                                          icon: Icons.local_shipping_outlined,
                                          child: _TwoColInfoGrid(
                                            items: [
                                              InfoItem(
                                                'رقم التتبع',
                                                state
                                                    .entity
                                                    .data
                                                    .shipmentDetails
                                                    .trackingNumber,
                                              ),
                                              InfoItem(
                                                'النوع',
                                                _shipmentTypeAr(
                                                  state
                                                      .entity
                                                      .data
                                                      .shipmentDetails
                                                      .type,
                                                ),
                                              ),
                                              InfoItem(
                                                'حالة الشحنة',
                                                _arabicStatus(
                                                  state
                                                      .entity
                                                      .data
                                                      .shipmentDetails
                                                      .status,
                                                ),
                                              ),
                                              InfoItem(
                                                'تاريخ الإنشاء',
                                                _fmtDateTime(
                                                  state
                                                      .entity
                                                      .data
                                                      .shipmentDetails
                                                      .createdAt,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  if (wide || medium)
                                    const SizedBox(width: 16)
                                  else
                                    const SizedBox(height: 16),

                                  // العمود الأيمن: التكاليف والإجماليات
                                  Expanded(
                                    flex: 1,
                                    child: _SectionCard(
                                      title: 'ملخّص التكاليف',
                                      icon: Icons.payments_outlined,
                                      padding: const EdgeInsets.fromLTRB(
                                        16,
                                        8,
                                        16,
                                        16,
                                      ),
                                      child: Column(
                                        children: [
                                          _CostRow(
                                            label: 'المبلغ الأساسي',
                                            value: _fmtMoney(
                                              state
                                                  .entity
                                                  .data
                                                  .costsBreakdown
                                                  .amount,
                                              state
                                                  .entity
                                                  .data
                                                  .invoiceDetails
                                                  .currency,
                                            ),
                                          ),
                                          _CostRow(
                                            label: 'الضريبة',
                                            value: _fmtMoney(
                                              state
                                                  .entity
                                                  .data
                                                  .costsBreakdown
                                                  .taxAmount,
                                              state
                                                  .entity
                                                  .data
                                                  .invoiceDetails
                                                  .currency,
                                            ),
                                          ),
                                          const Divider(height: 24),

                                          _CostRow(
                                            label: 'إعادة التغليف',
                                            value: _fmtMoney(
                                              state
                                                  .entity
                                                  .data
                                                  .costsBreakdown
                                                  .costOfRepacking,
                                              state
                                                  .entity
                                                  .data
                                                  .invoiceDetails
                                                  .currency,
                                            ),
                                          ),
                                          _CostRow(
                                            label: 'هشاشة الشحنة',
                                            value: _fmtMoney(
                                              state
                                                  .entity
                                                  .data
                                                  .costsBreakdown
                                                  .costOfIsFragile,
                                              state
                                                  .entity
                                                  .data
                                                  .invoiceDetails
                                                  .currency,
                                            ),
                                          ),
                                          _CostRow(
                                            label: 'تسليم في بلد المنشأ',
                                            value: _fmtMoney(
                                              state
                                                  .entity
                                                  .data
                                                  .costsBreakdown
                                                  .costDeliveryOrigin,
                                              state
                                                  .entity
                                                  .data
                                                  .invoiceDetails
                                                  .currency,
                                            ),
                                          ),
                                          _CostRow(
                                            label: 'شحن سريع (المنشأ)',
                                            value: _fmtMoney(
                                              state
                                                  .entity
                                                  .data
                                                  .costsBreakdown
                                                  .costExpressOrigin,
                                              state
                                                  .entity
                                                  .data
                                                  .invoiceDetails
                                                  .currency,
                                            ),
                                          ),
                                          _CostRow(
                                            label: 'جمارك (المنشأ)',
                                            value: _fmtMoney(
                                              state
                                                  .entity
                                                  .data
                                                  .costsBreakdown
                                                  .costCustomsOrigin,
                                              state
                                                  .entity
                                                  .data
                                                  .invoiceDetails
                                                  .currency,
                                            ),
                                          ),
                                          _CostRow(
                                            label: 'تسليم في بلد الوجهة',
                                            value: _fmtMoney(
                                              state
                                                  .entity
                                                  .data
                                                  .costsBreakdown
                                                  .costDeliveryDestination,
                                              state
                                                  .entity
                                                  .data
                                                  .invoiceDetails
                                                  .currency,
                                            ),
                                          ),
                                          _CostRow(
                                            label: 'الشحن الجوي',
                                            value: _fmtMoney(
                                              state
                                                  .entity
                                                  .data
                                                  .costsBreakdown
                                                  .airFreightCost,
                                              state
                                                  .entity
                                                  .data
                                                  .invoiceDetails
                                                  .currency,
                                            ),
                                          ),

                                          const SizedBox(height: 12),
                                          const Divider(height: 24),

                                          _MetricChipRow(
                                            chips: [
                                              _MetricChip(
                                                icon: Icons.scale_outlined,
                                                label: 'الوزن الإجمالي',
                                                value:
                                                    '${state.entity.data.totalWeight}',
                                                suffix: 'كغ',
                                                color: AppColors.brightBlue,
                                              ),
                                              _MetricChip(
                                                icon: Icons.attach_money,
                                                label: 'الإجمالي',
                                                value: _shortMoney(
                                                  state.entity.data.grandTotal,
                                                  state
                                                      .entity
                                                      .data
                                                      .invoiceDetails
                                                      .currency,
                                                ),
                                                color: AppColors.goldenYellow,
                                              ),
                                            ],
                                          ),

                                          const SizedBox(height: 12),
                                          _TotalBar(
                                            amount:
                                                state.entity.data.grandTotal,
                                            currency:
                                                state
                                                    .entity
                                                    .data
                                                    .invoiceDetails
                                                    .currency,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SliverToBoxAdapter(child: SizedBox(height: 24)),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else if (state is GetInvoiceDetailsLoading) {
              return CustomProgressIndicator();
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}

/* ===========================
 * Header
 * =========================== */
class _Header extends StatelessWidget {
  final String invoiceNumber;
  final String status;
  final num grandTotal;
  final String currency;
  final VoidCallback? onPrint;
  final VoidCallback? onDownload;

  const _Header({
    required this.invoiceNumber,
    required this.status,
    required this.grandTotal,
    required this.currency,
    this.onPrint,
    this.onDownload,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.deepPurple, AppColors.richPurple],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // شريط علوي (العنوان + حالة + أزرار)
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 12,
            runSpacing: 8,
            children: [
              Text(
                'فاتورة # $invoiceNumber',
                style: const TextStyle(
                  color: AppColors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              _StatusChip(status: status),
              const SizedBox(width: 8),
              _HeaderActions(onPrint: onPrint, onDownload: onDownload),
            ],
          ),
          const SizedBox(height: 16),
          // شريط ملخص
          _HeaderSummary(
            label: 'الإجمالي المستحق',
            value: _fmtMoney(grandTotal, currency),
          ),
        ],
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final String status;

  const _StatusChip({required this.status});

  @override
  Widget build(BuildContext context) {
    final s = status.toLowerCase();
    Color bg = AppColors.grey;
    Color fg = AppColors.black;

    if (s.contains('paid')) {
      bg = AppColors.green;
      fg = AppColors.white;
    } else if (s.contains('not')) {
      bg = AppColors.vibrantOrange;
      fg = AppColors.white;
    } else if (s.contains('delivered')) {
      bg = AppColors.brightBlue;
      fg = AppColors.white;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        _arabicStatus(status),
        style: TextStyle(color: fg, fontWeight: FontWeight.w600),
      ),
    );
  }
}

class _HeaderActions extends StatelessWidget {
  final VoidCallback? onPrint;
  final VoidCallback? onDownload;

  const _HeaderActions({this.onPrint, this.onDownload});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: [
        OutlinedButton.icon(
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.white,
            side: const BorderSide(color: AppColors.white),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: onPrint,
          icon: const Icon(Icons.print),
          label: const Text('طباعة'),
        ),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.goldenYellow,
            foregroundColor: AppColors.black,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: onDownload,
          icon: const Icon(Icons.download_outlined),
          label: const Text('تحميل PDF'),
        ),
      ],
    );
  }
}

class _HeaderSummary extends StatelessWidget {
  final String label;
  final String value;

  const _HeaderSummary({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white.withOpacity(.12),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white24),
      ),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(color: AppColors.white, fontSize: 14),
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

/* ===========================
 * Section Card + Info Grid
 * =========================== */
class _SectionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget child;
  final EdgeInsetsGeometry padding;

  const _SectionCard({
    required this.title,
    required this.icon,
    required this.child,
    this.padding = const EdgeInsets.all(16),
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: AppColors.white2,
                  child: Icon(icon, color: AppColors.deepPurple, size: 18),
                ),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.gunmetal,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }
}

class InfoItem {
  final String label;
  final String value;
  InfoItem(this.label, this.value);
}

class _TwoColInfoGrid extends StatelessWidget {
  final List<InfoItem> items;

  const _TwoColInfoGrid({required this.items});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final isTwoCols = c.maxWidth >= 520;
        final crossAxisCount = isTwoCols ? 2 : 1;

        return GridView.builder(
          itemCount: items.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            // ارتفاع العنصر
            childAspectRatio: isTwoCols ? 3.5 : 4.0,
          ),
          itemBuilder: (context, i) {
            final item = items[i];
            return _InfoTile(label: item.label, value: item.value);
          },
        );
      },
    );
  }
}

class _InfoTile extends StatelessWidget {
  final String label;
  final String value;

  const _InfoTile({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.white2,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.lightGray2),
      ),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              color: AppColors.gunmetal,
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: AppColors.grayDark),
            ),
          ),
        ],
      ),
    );
  }
}

/* ===========================
 * Costs + Totals
 * =========================== */
class _CostRow extends StatelessWidget {
  final String label;
  final String value;
  const _CostRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(color: AppColors.gunmetal),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: AppColors.deepPurple,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _MetricChipRow extends StatelessWidget {
  final List<_MetricChip> chips;
  const _MetricChipRow({required this.chips});

  @override
  Widget build(BuildContext context) {
    return Wrap(spacing: 8, runSpacing: 8, children: chips);
  }
}

class _MetricChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final String? suffix;
  final Color color;

  const _MetricChip({
    required this.icon,
    required this.label,
    required this.value,
    this.suffix,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: color.withOpacity(.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(.25)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(color: color, fontWeight: FontWeight.w600),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '${value}${suffix != null ? ' $suffix' : ''}',
              style: const TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TotalBar extends StatelessWidget {
  final num amount;
  final String currency;

  const _TotalBar({required this.amount, required this.currency});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: AppColors.deepPurple,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, 8),
            blurRadius: 16,
            color: Colors.black12,
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.summarize_outlined, color: AppColors.white),
          const SizedBox(width: 8),
          const Text(
            'الإجمالي',
            style: TextStyle(
              color: AppColors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          const Spacer(),
          Text(
            _fmtMoney(amount, currency),
            style: const TextStyle(
              color: AppColors.white,
              fontWeight: FontWeight.w800,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

/* ===========================
 * Helpers (formatting + mapping)
 * =========================== */
String _fmtDate(DateTime? d) {
  if (d == null) return '—';
  return DateFormat('yyyy-MM-dd').format(d);
}

String _fmtDateTime(DateTime? d) {
  if (d == null) return '—';
  return DateFormat('yyyy-MM-dd HH:mm').format(d);
}

String _fmtMoney(num v, String currency) {
  final withSep = NumberFormat('#,##0.##').format(v);
  return '$withSep $currency';
}

String _fmtMoneyNullable(num? v, String currency) {
  if (v == null) return '—';
  return _fmtMoney(v, currency);
}

String _shortMoney(num v, String currency) {
  if (v >= 1000000) {
    return '${(v / 1000000).toStringAsFixed(1)}M $currency';
  } else if (v >= 1000) {
    return '${(v / 1000).toStringAsFixed(1)}K $currency';
  }
  return _fmtMoney(v, currency);
}

String _arabicStatus(String status) {
  final s = status.toLowerCase();
  if (s.contains('not_paid')) return 'غير مدفوعة';
  if (s.contains('paid')) return 'مدفوعة';
  if (s.contains('delivered')) return 'تم التسليم';
  if (s.contains('ship')) return 'قيد الشحن';
  return status;
}

String _shipmentTypeAr(String type) {
  final s = type.toLowerCase();
  if (s == 'ship_only') return 'شحن فقط';
  return type;
}
