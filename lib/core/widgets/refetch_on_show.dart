

import 'package:flutter/widgets.dart';

class RefetchOnShow extends StatefulWidget {
  final bool isVisible;
  final VoidCallback onShow;
  final Widget child;

  const RefetchOnShow({
    super.key,
    required this.isVisible,
    required this.onShow,
    required this.child,
  });

  @override
  State<RefetchOnShow> createState() => _RefetchOnShowState();
}

class _RefetchOnShowState extends State<RefetchOnShow> {
  @override
  void initState() {
    super.initState();
    if (widget.isVisible) widget.onShow(); // أول مرة لو ظاهر
  }

  @override
  void didUpdateWidget(covariant RefetchOnShow oldWidget) {
    super.didUpdateWidget(oldWidget);
    // من غير ظاهر -> ظاهر: أعد الجلب
    if (!oldWidget.isVisible && widget.isVisible) widget.onShow();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
