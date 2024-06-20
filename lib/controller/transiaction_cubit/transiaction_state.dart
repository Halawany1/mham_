part of 'transiaction_cubit.dart';

@immutable
sealed class TransiactionState {}

class TransiactionInitial extends TransiactionState {}

class LoadingGetTransiactionState extends TransiactionState {}

class SuccessGetTransiactionState  extends TransiactionState {}

class ErrorGetTransiactionState extends TransiactionState {
  final String error;
  ErrorGetTransiactionState(this.error);
}

class LoadingGetWalletState extends TransiactionState {}

class SuccessGetWalletState  extends TransiactionState {}

class ErrorGetWalletState extends TransiactionState {
  final String error;
  ErrorGetWalletState(this.error);
}

