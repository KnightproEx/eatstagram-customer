import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/cart_bloc/cart_bloc.dart';
import '../../blocs/payment_bloc/payment_bloc.dart';
import '../../utils/round_number.dart';
import 'cart_item.dart';

class CartUI extends StatefulWidget {
  @override
  _CartUIState createState() => _CartUIState();
}

class _CartUIState extends State<CartUI> {
  CartBloc _cartBloc;

  @override
  void didChangeDependencies() {
    _cartBloc = BlocProvider.of<CartBloc>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final List<Map<String, dynamic>> _cart = _cartBloc.cart;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 25.0, bottom: 15),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Cart',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
          ),
        ),
        Expanded(
          child: Builder(
            builder: (context) => _cart.length == 0
                ? Center(
                    child: Text(
                      'no item in cart',
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.2),
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: _cart.length,
                    itemBuilder: (context, index) {
                      return CartItem(
                        _cart[index]['menu'],
                        _cart[index]['quantity'],
                      );
                    },
                  ),
          ),
        ),
        ListTile(
          title: Row(
            children: [
              Text(
                'Sub Total',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(width: width - 318),
              Container(
                width: 200,
                child: Text(
                  '\$${roundCurrency(_cartBloc.subtotal, 2)}',
                  textAlign: TextAlign.right,
                  style: TextStyle(fontSize: 22),
                ),
              ),
            ],
          ),
          subtitle: Row(
            children: [
              Text(
                'Service Tax (6%)',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(width: width - 388),
              Container(
                width: 200,
                child: Text(
                  '\$${roundCurrency(_cartBloc.tax, 2)}',
                  textAlign: TextAlign.right,
                  style: TextStyle(fontSize: 22),
                ),
              ),
            ],
          ),
        ),
        Divider(
          indent: 70,
          height: 5,
        ),
        ListTile(
          title: Row(
            children: [
              Text(
                'Total',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              SizedBox(width: width - 300),
              Container(
                width: 200,
                child: Text(
                  '\$${roundCurrency(_cartBloc.total, 2)}',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ),
            ],
          ),
        ),

        // Checkout Button
        Padding(
          padding: const EdgeInsets.only(
            top: 15.0,
            bottom: 25,
          ),
          child: FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
            color: Colors.black.withOpacity(0.9),
            textColor: Colors.white,
            minWidth: 250,
            height: 42,
            padding: EdgeInsets.all(8.0),
            onPressed: () {
              _cartBloc.add(CheckOut());
              BlocProvider.of<PaymentBloc>(context).add(ResetPaymentMethod());
            },
            child: Text(
              'CHECKOUT',
              style: TextStyle(fontSize: 16.0),
            ),
          ),
        ),
      ],
    );
  }
}
