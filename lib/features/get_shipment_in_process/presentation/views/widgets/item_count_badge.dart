import 'package:flutter/material.dart';

class ItemCountBadge extends StatelessWidget {
  final int count;
  final String label;        // مثال: "Items" أو "عناصر"
  final VoidCallback? onTap;
  final EdgeInsets padding;
  final double elevation;

  const ItemCountBadge({
    super.key,
    required this.count,
    this.label = 'Items',
    this.onTap,
    this.padding = const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
    this.elevation = 2,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bg = theme.colorScheme.primaryContainer;
    final fg = theme.colorScheme.onPrimaryContainer;

    return Material(
      color: bg,
      elevation: elevation,
      borderRadius: BorderRadius.circular(40),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(40),
        child: Padding(
          padding: padding,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.list_alt, size: 18, color: fg),
              const SizedBox(width: 8),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                transitionBuilder: (child, anim) =>
                    SizeTransition(sizeFactor: anim, axis: Axis.horizontal, child: child),
                child: Text(
                  '$count',
                  key: ValueKey(count),
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: fg, fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 6),
              Text(
                _pluralize(label, count),
                style: theme.textTheme.labelLarge?.copyWith(color: fg.withOpacity(0.85)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _pluralize(String label, int c) {
    // إنجليزي بسيط (عدِّله للعربية لو تحب)
    if (label.toLowerCase() == 'items') {
      return c == 1 ? 'Item' : 'Items';
    }
    // افتراضي: لا تغيّر
    return label;
  }
}
