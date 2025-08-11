import 'package:final_subul_project/core/routing/app_router.dart';
import 'package:final_subul_project/core/utils/service_locator.dart';
import 'package:final_subul_project/core/utils/simple_bloc_observer.dart';
import 'package:final_subul_project/features/sign_in/presentation/views/sign_in_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:intl/date_symbol_data_local.dart'; // لتهيئة بيانات التاريخ للعربية
import 'package:intl/intl.dart'; // لاختيار اللغة الافتراضية لـ intl

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setupServiceLocator();

  // يعمل مع intl 0.19.x
  await initializeDateFormatting('ar');
  Intl.defaultLocale = 'ar';

  Bloc.observer = SimpleBlocObserver();

  runApp(MyApp(appRouter: AppRouter()));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  const MyApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Subul Dashboard',

          // التوجيهات والمسارات
          onGenerateRoute: appRouter.generateRoute,

          // العربية كلغة افتراضية + دعم الإنجليزية
          locale: const Locale('en'),
          supportedLocales: const [
            Locale('ar'),
            Locale('en'),
          ],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],

          // الخطوط
          theme: ThemeData(
            textTheme: GoogleFonts.almaraiTextTheme(),
            useMaterial3: true,
          ),

          // أول شاشة
          home: const SignInScreen(),
        );
      },
    );
  }
}
