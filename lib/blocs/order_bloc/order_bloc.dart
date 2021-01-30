import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../exceptions/network_exception.dart';
import '../../models/order_model.dart';
import '../../models/response_model.dart';
import '../../services/main_api.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderModel _order = OrderModel('', '', '', 1, 0.0);

  OrderBloc() : super(OrderInitial());

  OrderModel get order => _order;

  @override
  Stream<OrderState> mapEventToState(OrderEvent event) async* {
    if (event is FetchOrder) {
      yield OrderLoading();

      try {
        DataModel result = await DataModelApi().post(
          'customer/fetch_order.php',
          {'id': event._id},
        );

        if (result.isError) {
          throw NetworkException(result.errorMsg);
        }

        if (result.count != 1) {
          throw InvalidInputException('Result count is not 1');
        }

        _order = OrderModel.fromJson(result.data);

        yield OrderLoaded(_order);
      } on FetchDataException catch (e) {
        yield OrderError(e.toString());
      } catch (e) {
        print(e.toString());
        yield OrderError('Something went wrong!');
      } finally {
        yield OrderInitial();
      }
    }
  }
}
