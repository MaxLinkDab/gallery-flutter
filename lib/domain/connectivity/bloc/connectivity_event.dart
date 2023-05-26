part of 'connectivity_bloc.dart';

abstract class ConnectivityEvent extends Equatable {
  const ConnectivityEvent();

  @override
  List<Object> get props => [];
}

class NotConnected extends ConnectivityEvent {}

class Connected extends ConnectivityEvent {}
