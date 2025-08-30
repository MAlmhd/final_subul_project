import 'package:final_subul_project/core/theming/app_colors.dart';
import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher_string.dart';
import 'dart:async';
import 'package:url_launcher/url_launcher_string.dart';

class InvoiceSection extends StatefulWidget {
  const InvoiceSection({super.key, required this.url});
  final String? url;

  @override
  State<InvoiceSection> createState() => InvoiceSectionState();
}

class InvoiceSectionState extends State<InvoiceSection> {
  int _retry = 0;
  bool _timedOut = false;
  Timer? _timer;

  bool get _hasUrl => widget.url != null && widget.url!.trim().isNotEmpty;
  bool get _isPdf => _hasUrl && widget.url!.toLowerCase().endsWith('.pdf');

  @override
  void initState() {
    super.initState();
    _startTimeout();
  }

  @override
  void didUpdateWidget(covariant InvoiceSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.url != widget.url) {
      _retry = 0;
      _timedOut = false;
      _startTimeout();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimeout() {
    _timer?.cancel();
    _timer = Timer(const Duration(seconds: 10), () {
      if (mounted) setState(() => _timedOut = true);
    });
  }

  void _cancelTimeout() {
    _timer?.cancel();
    _timer = null;
  }

  Future<void> _openInBrowser() async {
    if (_hasUrl) {
      await launchUrlString(widget.url!, mode: LaunchMode.externalApplication);
    }
  }

  void _openFullscreen() {
    if (!_hasUrl || _isPdf) return;
    showDialog(
      context: context,
      builder: (_) => Dialog(
        insetPadding: const EdgeInsets.all(16),
        child: InteractiveViewer(
          clipBehavior: Clip.none,
          child: Image.network(
            widget.url!, // بدون أي بارامترات
            fit: BoxFit.contain,
            errorBuilder: (_, __, ___) => const _InvoiceError(title: 'تعذّر فتح الصورة'),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!_hasUrl) {
      return const _InvoiceEmpty(
        title: 'لا توجد فاتورة مرفقة',
        subtitle: 'لم يتم رفع أي ملف فاتورة لهذه الشحنة.',
      );
    }

    if (_isPdf) {
      return _PdfCard(url: widget.url!, onOpen: _openInBrowser);
    }

    if (_timedOut) {
      return _InvoiceError(
        title: 'تعذّر تحميل الصورة',
        onRetry: () {
          setState(() {
            _retry++;
            _timedOut = false;
          });
          _startTimeout();
        },
        onOpenInBrowser: _openInBrowser,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text('ملف الفاتورة', style: TextStyle(fontWeight: FontWeight.w700)),
        const SizedBox(height: 8),
        InkWell(
          onTap: _openFullscreen,
          borderRadius: BorderRadius.circular(12),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(
                widget.url!, // 👈 بدون ?r=
                key: ValueKey('invoice_${widget.url}_${_retry}'), // يجبر إعادة التحميل
                fit: BoxFit.cover,
                // عندما يصل أول frame نعتبرها اكتملت ونلغي الـ timeout
                frameBuilder: (context, child, frame, wasSync) {
                  if (frame != null || wasSync) {
                    _cancelTimeout();
                    return child;
                  }
                  return Container(
                    color: AppColors.white2,
                    alignment: Alignment.center,
                    child: const SizedBox(
                      width: 26,
                      height: 26,
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
                errorBuilder: (_, __, ___) {
                  _cancelTimeout();
                  return _InvoiceError(
                    title: 'تعذّر تحميل الصورة',
                    onRetry: () {
                      setState(() {
                        _retry++;
                        _timedOut = false;
                      });
                      _startTimeout();
                    },
                    onOpenInBrowser: _openInBrowser,
                  );
                },
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton.icon(
            onPressed: _openInBrowser,
            icon: const Icon(Icons.open_in_new, size: 18, color: AppColors.deepPurple),
            label: const Text('فتح في المتصفح', style: TextStyle(color: AppColors.deepPurple)),
          ),
        ),
      ],
    );
  }
}


class _PdfCard extends StatelessWidget {
  const _PdfCard({required this.url, required this.onOpen});
  final String url;
  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white2,
        border: Border.all(color: AppColors.lightGray),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.picture_as_pdf, color: AppColors.vibrantOrange),
          const SizedBox(width: 10),
          Expanded(
            child: Text(url,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textDirection: TextDirection.ltr,
              style: const TextStyle(color: AppColors.gunmetal),
            ),
          ),
          const SizedBox(width: 10),
          ElevatedButton(
            onPressed: onOpen,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.deepPurple,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              elevation: 0,
            ),
            child: const Text('فتح'),
          ),
        ],
      ),
    );
  }
}

class _InvoiceError extends StatelessWidget {
  const _InvoiceError({this.title, this.onRetry, this.onOpenInBrowser});
  final String? title;
  final VoidCallback? onRetry;
  final VoidCallback? onOpenInBrowser;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white2,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.broken_image_outlined, size: 36, color: AppColors.mediumGray),
            const SizedBox(height: 8),
            Text(title ?? 'تعذّر تحميل الصورة', style: const TextStyle(color: AppColors.gunmetal)),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              children: [
                if (onRetry != null)
                  OutlinedButton(
                    onPressed: onRetry,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.deepPurple,
                      side: const BorderSide(color: AppColors.deepPurple),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text('إعادة المحاولة'),
                  ),
                if (onOpenInBrowser != null)
                  TextButton(
                    onPressed: onOpenInBrowser,
                    child: const Text('فتح في المتصفح'),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _InvoiceEmpty extends StatelessWidget {
  const _InvoiceEmpty({required this.title, this.subtitle});
  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.lightGray),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.receipt_long_outlined, color: AppColors.deepPurple),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
                if (subtitle != null)
                  Text(subtitle!, style: const TextStyle(color: AppColors.mediumGray, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
