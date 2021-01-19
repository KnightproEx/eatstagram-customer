part of 'payment_bloc.dart';

abstract class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object> get props => [];
}

class PaymentInitial extends PaymentState {}

class PaymentLoading extends PaymentState {}

class PaymentError extends PaymentState {
  final String _message;

  PaymentError(this._message);

  String get message => _message;

  @override
  List<Object> get props => [_message];
}

class PaymentMethodChanged extends PaymentState {}

class PaymentSuccess extends PaymentState {}
