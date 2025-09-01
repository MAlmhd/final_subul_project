import 'package:final_subul_project/core/helpers/extensions.dart';
import 'package:final_subul_project/core/routing/routes.dart';
import 'package:final_subul_project/core/widgets/custom_progress_indicator.dart';
import 'package:final_subul_project/features/get_unapproved_shipments/presentation/views/widgets/invoice_section.dart';
import 'package:final_subul_project/features/track_shipments_home/domain/entities/approved_shipment_entity/approved_shipment_entity.dart';
import 'package:flutter/material.dart';
import 'package:final_subul_project/core/theming/app_colors.dart';

class ShipmentDetailsCard extends StatefulWidget {
  const ShipmentDetailsCard({super.key, required this.data});

  final ApprovedShipmentEntity data;

  @override
  State<ShipmentDetailsCard> createState() => _ShipmentDetailsCardState();
}

class _ShipmentDetailsCardState extends State<ShipmentDetailsCard> {
  final TextEditingController reasonController = TextEditingController();

  Color _statusColor(String? status) {
    if (status == null || status.trim().isEmpty) return AppColors.mediumGray;
    final s = status.toLowerCase();
    if (s.contains('approved') ||
        s.contains('delivered') ||
        s.contains('done')) {
      return AppColors.green;
    } else if (s.contains('pending') || s.contains('process')) {
      return AppColors.brightBlue;
    } else if (s.contains('rejected') || s.contains('cancel')) {
      return AppColors.vibrantOrange;
    }
    return AppColors.deepPurple;
  }

  @override
  void dispose() {
    reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final statusText =
        (widget.data.statusOfShipment == null ||
                widget.data.statusOfShipment!.isEmpty)
            ? '—'
            : widget.data.statusOfShipment!;
    final statusColor = _statusColor(widget.data.statusOfShipment);

    return Scaffold(
      appBar: AppBar(),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 920),
              child: Container(
                constraints: const BoxConstraints(maxWidth: 840),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 18,
                ),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.lightGray, width: 1),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 18,
                      spreadRadius: 2,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    /// Header
                    Row(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: AppColors.deepPurple.withOpacity(.08),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.local_shipping_outlined,
                            color: Color(0xFF29206F),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text(
                                'تفاصيل الشحنة',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.deepPurple,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Wrap(
                                spacing: 8,
                                runSpacing: 6,
                                alignment: WrapAlignment.end,
                                children: [
                                  _Chip(
                                    label: 'نوع: ${widget.data.typeOfShipment}',
                                  ),
                                  _Chip(
                                    label:
                                        'العميل: ${widget.data.nameOfCustomer}',
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    /// Content tiles (تخذ عرضًا محدودًا)
                    LayoutBuilder(
                      builder: (ctx, c) {
                        final tileWidth =
                            c.maxWidth >= 640
                                ? c.maxWidth / 3 - 12
                                : c.maxWidth; // 3 أعمدة على العريض
                        return Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: [
                            _InfoTile(
                              width: tileWidth,
                              icon: Icons.qr_code_2,
                              label: 'رقم التتبع',
                              value: widget.data.trackingString,
                            ),
                            _InfoTile(
                              width: tileWidth,
                              icon: Icons.inventory_2_outlined,
                              label: 'عدد الطرود',
                              value: '${widget.data.numberOfShipment}',
                            ),
                            _InfoTile(
                              width: tileWidth,
                              icon: Icons.verified_outlined,
                              label: 'الحالة',
                              valueWidget: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: statusColor.withOpacity(.12),
                                      borderRadius: BorderRadius.circular(999),
                                      border: Border.all(
                                        color: statusColor,
                                        width: 1,
                                      ),
                                    ),
                                    child: Text(
                                      statusText,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: statusColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),

                    const SizedBox(height: 18),

                    InvoiceSection(url: widget.data.invoiceFile),
                    const SizedBox(height: 18),

                    /// Actions (أزرار بعرض منطقي بدل ممتد)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 220,
                          child: ElevatedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (_) => const CustomProgressIndicator(),
                              );
                              context.pushNamed(
                                Routes.payTheBill,
                                arguments: widget.data,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.deepPurple,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 0,
                            ),
                            child: const Text(
                              'انشاء فاتورة',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Chip صغيرة للهيدر
class _Chip extends StatelessWidget {
  const _Chip({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.white2,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.lightGray, width: 1),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 12, color: AppColors.gunmetal),
      ),
    );
  }
}

/// عنصر معلومة موحَّد الشكل
class _InfoTile extends StatelessWidget {
  const _InfoTile({
    required this.icon,
    required this.label,
    this.value,
    this.valueWidget,
    required this.width,
  });

  final IconData icon;
  final String label;
  final String? value;
  final Widget? valueWidget;
  final double width;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: 220, maxWidth: width),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.white2,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.lightGray, width: 1),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.deepPurple, size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    label,
                    style: const TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                  const SizedBox(height: 4),
                  if (valueWidget != null)
                    valueWidget!
                  else
                    Text(
                      value ?? '—',
                      textAlign: TextAlign.right,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.gunmetal,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
