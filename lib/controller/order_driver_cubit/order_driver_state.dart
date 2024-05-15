part of 'order_driver_cubit.dart';

@immutable
sealed class OrderDriverState {}

class OrderDriverInitial extends OrderDriverState {}

class ChangeCheckBoxListTileState extends OrderDriverState {}

class ChangeProductDetailsContainerState extends OrderDriverState {}

class LoadingGetAllOrdersState extends OrderDriverState {}

class SuccessGetAllOrdersState extends OrderDriverState {}
class NoInternetHomeState extends OrderDriverState {}

class ErrorGetAllOrdersState extends OrderDriverState {

  final String error;
  ErrorGetAllOrdersState(this.error);
}


class LoadingGetOrderByIdState extends OrderDriverState {}

class SuccessGetOrderByIdState extends OrderDriverState {}

class ErrorGetOrderByIdState extends OrderDriverState {

  final String error;
  ErrorGetOrderByIdState(this.error);
}


class LoadingCancelOrderDriverState extends OrderDriverState {}

class SuccessCancelOrderDriverState extends OrderDriverState {}

class ErrorCancelOrderDriverState extends OrderDriverState {

  final String error;
  ErrorCancelOrderDriverState(this.error);
}


class SuccessTakeTheOrderState extends OrderDriverState {}

class ErrorTakeTheOrderState extends OrderDriverState {

  final String error;
  ErrorTakeTheOrderState(this.error);
}