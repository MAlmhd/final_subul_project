import 'package:flutter/material.dart';
import 'package:final_subul_project/core/helpers/styles.dart';
import 'package:final_subul_project/core/theming/app_colors.dart';

class BuildAnimatedWelcomeText extends StatelessWidget {
  const BuildAnimatedWelcomeText({super.key});
  // final double opacity;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'أهلاً بك في سُبُل',
        style: Styles.textStyle10Sp.copyWith(color: AppColors.deepPurple),
      ),
    );
  }
}

/**
 * return Center(
      child: AnimatedOpacity(
        duration: const Duration(seconds: 2),
        opacity: opacity,
        child: Text(
          'أهلاً بك في سُبُل',
          style: Styles.textStyle10Sp.copyWith(color: AppColors.deepPurple,),
        ),
      ),
    );
 */
