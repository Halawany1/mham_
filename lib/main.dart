import 'dart:ui';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mham/controller/Authentication_cubit/authentication_cubit.dart';
import 'package:mham/core/constent/color/color_constant.dart';
import 'package:mham/core/constent/images/image_constant.dart';
import 'package:mham/core/style/theme.dart';
import 'package:mham/l10n/l10n.dart';
import 'package:mham/views/on_boarding_screen/on_boarding_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main()  {
  WidgetsFlutterBinding.ensureInitialized();
  // await CacheHelper.init();
  // await DioHelper.init();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(
     const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthenticationCubit(),
        )
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(

            theme: lightTheme(),
            locale: Locale('ar'),
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: L10n.all,
            debugShowCheckedModeBanner: false,
            home: AnimatedSplashScreen(
              nextScreen:  const OnBoardingScreen(),
              duration: 1000,
              splashIconSize: 100.w,
              backgroundColor: ColorConstant.white,
              splash:ImageConstant.splash ,
              curve: Curves.easeOutSine,
              pageTransitionType:
              PageTransitionType.rightToLeftWithFade,
              splashTransition: SplashTransition.sizeTransition,
            ),
          );
        },

      ),
    );
  }
}