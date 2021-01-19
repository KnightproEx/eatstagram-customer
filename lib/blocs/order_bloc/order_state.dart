part of 'order_bloc.dart';

abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class OrderError extends OrderState {
  final String _message;

  OrderError(this._message);

  String get message => _message;

  @override
  List<Object> get props => [_message];
}

class OrderLoaded extends OrderState {
  final OrderModel _order;

  OrderLoaded(this._order);

  OrderModel get order => _order;

  @override
  List<Object> get props => [_order];
}
