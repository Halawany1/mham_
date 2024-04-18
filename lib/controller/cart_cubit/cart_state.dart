part of 'cart_cubit.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

class CartLoadingState extends CartState {}

class CartSuccessState extends CartState {}

class CartErrorState extends CartState {
  final String error;
  CartErrorState(this.error);
}


class LoadingAddToCart extends CartState {}

class SuccessAddToCart extends CartState {}

class ErrorAddToCart extends CartState {
  final String error;
  ErrorAddToCart(this.error);
}

class LoadingUpdateCart extends CartState {}

class SuccessUpdateCart extends CartState {}

class ErrorUpdateCart extends CartState {
  final String error;
  ErrorUpdateCart(this.error);
}



class LoadingDeleteCart extends CartState {}

class SuccessDeleteCart extends CartState {}

class ErrorDeleteCart extends CartState {
  final String error;
  ErrorDeleteCart(this.error);
}
