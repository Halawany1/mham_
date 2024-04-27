import 'dart:ui';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mham/controller/Authentication_cubit/authentication_cubit.dart';
import 'package:mham/controller/cart_cubit/cart_cubit.dart';
import 'package:mham/controller/home_cubit/home_cubit.dart';
import 'package:mham/controller/layout_cubit/layout_cubit.dart';
import 'package:mham/controller/profile_cubit/profile_cubit.dart';
import 'package:mham/core/constent/app_constant.dart';
import 'package:mham/core/constent/color_constant.dart';
import 'package:mham/core/constent/image_constant.dart';
import 'package:mham/core/network/bloc_observer.dart';
import 'package:mham/core/network/local.dart';
import 'package:mham/core/network/remote.dart';
import 'package:mham/core/style/theme.dart';
import 'package:mham/l10n/l10n.dart';
import 'package:mham/layout/layout_screen.dart';
import 'package:mham/views/login_screen/login_screen.dart';
import 'package:mham/views/on_boarding_screen/on_boarding_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await DioHelper.init();
 //await CacheHelper.deleteAllData();
 //  await Firebase.initializeApp();
 //  var token = await FirebaseMessaging.instance.getToken();
 //  print(token);

  Bloc.observer = MyBlocObserver();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  Widget widget;

  if (CacheHelper.getData(key: AppConstant.theme) == null) {
    CacheHelper.saveData(key: AppConstant.theme, value: true);
  }
  if (CacheHelper.getData(key: AppConstant.onBoarding) == null) {
    widget = const OnBoardingScreen();
  } else {
    widget = const LayoutScreen();
  }
  print(CacheHelper.getData(key: AppConstant.token));
  runApp(
    MyApp(
      widget: widget,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.widget});

  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [

        BlocProvider(
          create: (context) => LayoutCubit(),
        ),
        BlocProvider(
          create: (context) =>
          HomeCubit(),
        ),
        BlocProvider(
          create: (context) => AuthenticationCubit(),
        ),
        BlocProvider(
          create: (context) => ProfileCubit()..getProfile(),
        ),
        BlocProvider(
          create: (context) =>
          CartCubit()
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return BlocBuilder<LayoutCubit, LayoutState>(
            builder: (context, state) {
              var cubit = context.read<LayoutCubit>();
              return MaterialApp(
                theme: cubit.theme?lightTheme():darkTheme(),
                locale: Locale(cubit.lang),
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                ],
                supportedLocales: L10n.all,
                debugShowCheckedModeBanner: false,
                home: AnimatedSplashScreen(
                  nextScreen: widget,
                  duration: 1000,
                  splashIconSize: 100.w,
                  backgroundColor: ColorConstant.white,
                  splash: ImageConstant.splash,
                  curve: Curves.easeOutSine,
                  pageTransitionType: PageTransitionType.rightToLeftWithFade,
                  splashTransition: SplashTransition.sizeTransition,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
