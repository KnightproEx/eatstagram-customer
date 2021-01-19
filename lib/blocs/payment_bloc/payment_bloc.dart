import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../exceptions/network_exception.dart';
import '../../models/response_model.dart';
import '../../services/main_api.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentMethod _paymentMethod;
  String _orderID;

  PaymentBloc()
      : _paymentMethod = PaymentMethod.none,
        _orderID = '',
        super(PaymentInitial());

  PaymentMethod get paymentMethod => _paymentMethod;
  String get orderID => _orderID;

  @override
  Stream<PaymentState> mapEventToState(PaymentEvent event) async* {
    yield PaymentInitial();

    if (event is SetPaymentMethod) {
      _paymentMethod = event._paymentMethod;
      yield PaymentMethodChanged();
    }

    if (event is ResetPaymentMethod) {
      _paymentMethod = PaymentMethod.none;
    }

    if (event is MakePayment) {
      yield PaymentLoading();

      try {
        if (_paymentMethod == PaymentMethod.none) {
          yield PaymentError('Please select a payment method');
          return;
        }

        List<Map<String, dynamic>> itemList = [];

        event._cart.forEach((element) {
          itemList.add({
            'menu': element['menu'].id,
            'quantity': element['quantity'],
          });
        });

        DataModel result = await DataModelApi().post(
          'customer/order.php',
          {
            'table': event._table,
            'time': DateTime.now().toString(),
            'payment': _paymentMethod.index.toString(),
            'item': itemList,
          },
        );

        if (result.isError) {
          throw NetworkException(result.errorMsg);
        }

        _orderID = result.data['id'];

        yield PaymentSuccess();
      } on FetchDataException catch (e) {
        yield PaymentError(e.toString());
      } catch (e) {
        print(e.toString());
        yield PaymentError('Something went wrong!');
      } finally {
        yield PaymentInitial();
      }
    }
  }
}
