part of 'transiaction_cubit.dart';

@immutable
sealed class TransiactionState {}

class TransiactionInitial extends TransiactionState {}

class LoadingGetTransiactionState extends TransiactionState {}

class SuccessGetTransiactionState extends TransiactionState {}

class ErrorGetTransiactionState extends TransiactionState {
  final String error;
  ErrorGetTransiactionState(this.error);
}

