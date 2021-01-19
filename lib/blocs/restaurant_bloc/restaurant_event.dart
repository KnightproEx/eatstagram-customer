part of 'restaurant_bloc.dart';

abstract class RestaurantEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class Scan extends RestaurantEvent {}
