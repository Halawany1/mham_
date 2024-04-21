part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

class LoadingProfileState extends ProfileState {}

class SuccessProfileState extends ProfileState {}
class ErrorProfileState extends ProfileState {

  final String message;

  ErrorProfileState(this.message);
}


class LoadingUpdateProfileState extends ProfileState {}

class SuccessUpdateProfileState extends ProfileState {}

class ErrorUpdateProfileState extends ProfileState {
  final String message;

  ErrorUpdateProfileState(this.message);
}