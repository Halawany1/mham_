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

class ErrorIncreaseReviewState extends HomeState {
  final String error;

  ErrorIncreaseReviewState(this.error);
}

