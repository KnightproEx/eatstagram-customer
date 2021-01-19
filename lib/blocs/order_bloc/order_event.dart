part of 'order_bloc.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class FetchOrder extends OrderEvent {
  final String _id;

  FetchOrder(this._id);

  @override
  List<Object> get props => [_id];
}
