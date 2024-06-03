part of 'authentication_cubit.dart';

@immutable
abstract class AuthenticationState {}

class AuthenticationInitial extends AuthenticationState {}

class ChangeVisibalityPasswordState extends AuthenticationState {}

class ResetVisibalityPasswordState extends AuthenticationState {}

class ChangeRememberCheckState extends AuthenticationState {}

class LoadingLoginUserState extends AuthenticationState {}

class SuccessLoginUserState extends AuthenticationState {}
class NoInternetAuthState extends AuthenticationState {}

class ChangeIndexOtpVerificationState extends AuthenticationState {}

class ErrorLoginUserState extends AuthenticationState {
  final String error;

  ErrorLoginUserState(this.error);
}


class LoadingRegisterUserState extends AuthenticationState {}

class SuccessRegisterUserState extends AuthenticationState {}

class ErrorRegisterUserState extends AuthenticationState {
  final String error;

  ErrorRegisterUserState(this.error);
}

class SelectCountryCodeState extends AuthenticationState {}

class SelectCountryIdState extends AuthenticationState {}

class SelectSellerTypeState extends AuthenticationState {}

class LoadingGetCountriesState extends AuthenticationState {}

class SuccessGetCountriesState extends AuthenticationState {}

class ErrorGetCountriesState extends AuthenticationState {
  final String error;

  ErrorGetCountriesState(this.error);
}

class LoadingGetOtpState extends AuthenticationState {}

class SuccessGetOtpState extends AuthenticationState {}

class ErrorGetOtpState extends AuthenticationState {
  final String error;

  ErrorGetOtpState(this.error);
}


