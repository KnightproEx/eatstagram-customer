part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class CartError extends CartState {
  final String _message;

  CartError(this._message);

  String get message => _message;

  @override
  List<Object> get props => [_message];
}

class CartLoaded extends CartState {}

class CartSubmitted extends CartState {}
