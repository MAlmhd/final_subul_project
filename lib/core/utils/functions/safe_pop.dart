import 'package:flutter/material.dart';

bool _didSafePop = false;

Future<void> safePop(BuildContext context, [Object? result]) async {
  // لو سبق ونفذنا pop لا نعيده
  if (_didSafePop) return;

  // هذا الـ Route هو الحالي؟
  final route = ModalRoute.of(context);
  if (route == null || !route.isCurrent) return;

  // لا تحاول pop لو ما في شيء تنسحبه
  if (!Navigator.of(context).canPop()) return;

  _didSafePop = true;

  // أغلق أي SnackBar/رسائل قبل الرجوع
  ScaffoldMessenger.of(context).hideCurrentSnackBar();

  // انتظر لنهايتين: بعد الفريم + ميكروتاسك (نضمن أن النافيجيتور غير "مُقفل")
  WidgetsBinding.instance.addPostFrameCallback((_) async {
    await Future<void>.delayed(const Duration(milliseconds: 16));
    if (context.mounted) {
      Navigator.of(context).pop(result);
    }
  });
}
