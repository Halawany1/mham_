part of 'internet_cubit.dart';

@immutable
sealed class InternetState {}

final class InternetInitial extends InternetState {}

class InternetConnected extends InternetState {

  final bool isConnected;

  InternetConnected(this.isConnected);
}

class InternetNotConnected extends InternetState {}
