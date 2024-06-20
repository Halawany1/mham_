part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

class LoadingProfileState extends ProfileState {}
class NoInternetProfileState extends ProfileState {}

class SuccessProfileState extends ProfileState {}
class ErrorProfileState extends ProfileState {

  final String message;

  ErrorProfileState(this.message);
}


class LoadingUpdateProfileState extends ProfileState {}
class SuccessPickImageState extends ProfileState {}

class SuccessUpdateProfileState extends ProfileState {}

class ErrorUpdateProfileState extends ProfileState {
  final String message;

  ErrorUpdateProfileState(this.message);
}
class LoadingUpdateProfileDriverState extends ProfileState {}


class SuccessUpdateProfileDriverState extends ProfileState {}

class ErrorUpdateProfileDriverState extends ProfileState {
  final String message;

  ErrorUpdateProfileDriverState(this.message);
}

class LoadingDeleteAccount extends ProfileState {}


class SuccessDeleteAccount extends ProfileState {}


class ErrorDeleteAccount extends ProfileState {
  final String message;

  ErrorDeleteAccount(this.message);
}

class LoadingLogOutState extends ProfileState {}


class SuccessLogOutState extends ProfileState {}


class ErrorLogOutState extends ProfileState {
  final String message;

  ErrorLogOutState(this.message);
}