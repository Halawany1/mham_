part of 'layout_cubit.dart';

@immutable
sealed class LayoutState {}

final class LayoutInitial extends LayoutState {}

class LayoutChangeIndexState extends LayoutState {}

class LayoutChangeLanguageState extends LayoutState {}


class LayoutChangeThemeModeState extends LayoutState {}


