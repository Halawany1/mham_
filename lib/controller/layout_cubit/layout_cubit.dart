import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:mham/core/constent/app_constant.dart';
import 'package:mham/core/network/local.dart';
import 'package:mham/views/home_screen/home_screen.dart';
import 'package:mham/views/profile_screen/profile_screen.dart';
part 'layout_state.dart';

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit() : super(LayoutInitial());

  static LayoutCubit get(context) => BlocProvider.of(context);

  List<Widget>screens=[
    HomeScreen(),
   ProfileScreen(),
  ];
  int index=0;
  void changeIndex(int value) {
    index=value;
    emit(LayoutChangeIndexState());
  }

  String lang=CacheHelper.getData(key: AppConstant.lang)??"en";
  void changeLang(String value) {
    lang=value;
    CacheHelper.saveData(key: AppConstant.lang, value: lang);
    emit(LayoutChangeLanguageState());
  }

  bool theme=CacheHelper.getData(key: AppConstant.theme);

  void changeTheme(bool value) {
    theme=value;
    CacheHelper.saveData(key: AppConstant.theme, value: theme);
    emit(LayoutChangeThemeModeState());
  }

  bool hideNav=false;
  void changeHideNav(bool value) {
    hideNav=value;
    emit(LayoutChangeHideNavState());
  }
}
