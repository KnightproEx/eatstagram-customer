part of 'restaurant_bloc.dart';

abstract class RestaurantState extends Equatable {
  @override
  List<Object> get props => [];
}

class RestaurantInitial extends RestaurantState {}

class RestaurantLoading extends RestaurantState {}

class RestaurantError extends RestaurantState {
  final String _message;

  RestaurantError(this._message);

  String get message => _message;

  @override
  List<Object> get props => [_message];
}

class RestaurantLoaded extends RestaurantState {}
