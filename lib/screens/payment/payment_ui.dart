import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../../blocs/cart_bloc/cart_bloc.dart';
import '../../blocs/payment_bloc/payment_bloc.dart';
import '../../blocs/restaurant_bloc/restaurant_bloc.dart';

class PaymentUI extends StatefulWidget {
  @override
  _PaymentUIState createState() => _PaymentUIState();
}

class _PaymentUIState extends State<PaymentUI> {
  PaymentBloc _paymentBloc;

  @override
  void didChangeDependencies() {
    _paymentBloc = BlocProvider.of<PaymentBloc>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentBloc, PaymentState>(
      buildWhen: (_, current) => current is! PaymentError,
      builder: (context, state) {
        return Stack(
          children: [
            Container(
              alignment: Alignment.topCenter,
              child: Text(
                'Payment',
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 60, left: 20.0, right: 20.0),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () => _paymentBloc.add(
                      SetPaymentMethod(PaymentMethod.online),
                    ),
                    child: Card(
                      color: _paymentBloc.paymentMethod == PaymentMethod.online
                          ? Colors.blue[200]
                          : null,
                      child: ListTile(
                        leading: Icon(
                          FontAwesome.bank,
                          color: Colors.blueAccent,
                        ),
                        title: Text('Online Banking'),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _paymentBloc.add(
                      SetPaymentMethod(PaymentMethod.card),
                    ),
                    child: Card(
                      color: _paymentBloc.paymentMethod == PaymentMethod.card
                          ? Colors.blue[200]
                          : null,
                      child: ListTile(
                        leading: Icon(
                          FontAwesome.credit_card,
                          color: Colors.redAccent,
                        ),
                        title: Text('Credit/Debit Card'),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _paymentBloc.add(
                      SetPaymentMethod(PaymentMethod.bitcoin),
                    ),
                    child: Card(
                      color: _paymentBloc.paymentMethod == PaymentMethod.bitcoin
                          ? Colors.blue[200]
                          : null,
                      child: ListTile(
                        leading: Icon(
                          FontAwesome.bitcoin,
                          color: Colors.orange,
                        ),
                        title: Text('Bitcoin'),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _paymentBloc.add(
                      SetPaymentMethod(PaymentMethod.cash),
                    ),
                    child: Card(
                      color: _paymentBloc.paymentMethod == PaymentMethod.cash
                          ? Colors.blue[200]
                          : null,
                      child: ListTile(
                        leading: Icon(
                          FontAwesome.money,
                          color: Colors.green,
                        ),
                        title: Text('Cash at Counter'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 50),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  color: Colors.black.withOpacity(0.9),
                  textColor: Colors.white,
                  minWidth: 250,
                  height: 42,
                  padding: EdgeInsets.all(8.0),
                  onPressed: () => _paymentBloc.add(MakePayment(
                    BlocProvider.of<RestaurantBloc>(context).table.toString(),
                    BlocProvider.of<CartBloc>(context).cart,
                  )),
                  child: Text(
                    'PAY',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
