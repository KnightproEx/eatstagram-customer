part of 'payment_bloc.dart';

abstract class PaymentEvent extends Equatable {
  const PaymentEvent();

  @override
  List<Object> get props => [];
}

class SetPaymentMethod extends PaymentEvent {
  final PaymentMethod _paymentMethod;

  SetPaymentMethod(this._paymentMethod);

  @override
  List<Object> get props => [_paymentMethod];
}

class ResetPaymentMethod extends PaymentEvent {}

class MakePayment extends PaymentEvent {
  final String _table;
  final List<Map<String, dynamic>> _cart;

  MakePayment(this._table, this._cart);

  @override
  List<Object> get props => [_table, _cart];
}

enum PaymentMethod {
  none,
  online,
  card,
  bitcoin,
  cash,
}
