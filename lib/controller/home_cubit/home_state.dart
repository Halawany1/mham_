part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

class LoadingGetAllProduct extends HomeState {}

class SuccessGetAllProduct extends HomeState {}

class ErrorGetAllProduct extends HomeState {
  final String error;

  ErrorGetAllProduct(this.error);
}

class SuccessGetCarModelsState extends HomeState {}

class ErrorGetCarModelsState extends HomeState {
  final String error;

  ErrorGetCarModelsState(this.error);
}

class LoadingSelectCarTypeState extends HomeState {}

class SucccessSelectCarTypeState extends HomeState {}

class SucccessSelectYearState extends HomeState {}

class RemoveSelectionCarModels extends HomeState {}

class ChangeProductDetailsContainerState extends HomeState {}

class ChangeQuantityState extends HomeState {}

class IncreaseReviewState extends HomeState {}

class ChangeTypeCarIndexState extends HomeState {}

class ErrorIncreaseReviewState extends HomeState {
  final String error;

  ErrorIncreaseReviewState(this.error);
}


class LoadingGetProductByIDState extends HomeState {}

class SuccessGetProductByIDState extends HomeState {}

class ErrorGetProductByIDState extends HomeState {
  final String error;

  ErrorGetProductByIDState(this.error);
}
class LoadingAddScrapState extends HomeState {}

class SuccessAddScrapState extends HomeState {
  final RequestScrapModel data;
  SuccessAddScrapState(this.data);
}

class ErrorAddScrapState extends HomeState {
  final String error;

  ErrorAddScrapState(this.error);
}
class LoadingAddAndRemoveFavoriteState extends HomeState {}

class SuccessAddAndRemoveFavoriteState extends HomeState {}
class ChangeOrderDetailsContainerState extends HomeState {}
class Change extends HomeState {}

class ErrorAddAndRemoveFavoriteState extends HomeState {
  final String error;

  ErrorAddAndRemoveFavoriteState(this.error);
}
class LoadingGetAllOrdersState extends HomeState {}

class SuccessGetAllOrdersState extends HomeState {}

class ErrorGetAllOrdersState extends HomeState {
  final String error;

  ErrorGetAllOrdersState(this.error);
}
class LoadingCancelProductState extends HomeState {}

class SuccessCancelProductState extends HomeState {}

class ErrorCancelProductState extends HomeState {
  final String error;

  ErrorCancelProductState(this.error);
}
class LoadingCancelOrderState extends HomeState {}

class SuccessCancelOrderState extends HomeState {}

class ErrorCancelOrderState extends HomeState {
  final String error;

  ErrorCancelOrderState(this.error);
}
