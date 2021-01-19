import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/menu_model.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  Map<String, Map<String, dynamic>> _cart;

  CartBloc()
      : _cart = {},
        super(CartInitial());

  List<Map<String, dynamic>> get cart {
    List<Map<String, dynamic>> temp = [];
    _cart.forEach((key, value) {
      temp.add(value);
    });

    return temp;
  }

  double get subtotal {
    double subtotal = 0;

    _cart.forEach(
      (key, value) => subtotal += value['menu'].price * value['quantity'],
    );

    return subtotal;
  }

  double get tax => subtotal * 0.06;
  double get total => subtotal + tax;

  @override
  Stream<CartState> mapEventToState(CartEvent event) async* {
    yield CartInitial();

    if (event is InitializeCart) {
      _cart.clear();
    }

    if (event is AddItem) {
      if (!_cart.containsKey(event._menu.id)) {
        _cart[event._menu.id] = {
          'menu': event._menu,
          'quantity': event._quantity,
        };

        return;
      }

      _cart[event._menu.id]['quantity'] += event._quantity;
    }

    if (event is ItemIncrement) {
      _cart[event._id]['quantity'] +=
          _cart[event._id]['quantity'] >= 20 ? 0 : 1;
      yield CartLoaded();
    }

    if (event is ItemDecrement) {
      _cart[event._id]['quantity'] -= _cart[event._id]['quantity'] <= 0 ? 0 : 1;
      yield CartLoaded();
    }

    if (event is RemoveItem) {
      _cart.remove(event._id);
      yield CartLoaded();
    }

    if (event is CheckOut) {
      if (_cart.isEmpty) {
        yield CartError('Cart is empty');
        return;
      }

      yield CartSubmitted();
    }
  }
}
