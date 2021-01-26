import 'package:eatstagram/screens/restaurant/restaurant.dart';
import 'package:eatstagram/screens/scanner/scanner_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/cart_bloc/cart_bloc.dart';
import '../../blocs/order_bloc/order_bloc.dart';
import '../../models/order_model.dart';
import '../../utils/round_number.dart';

class ThankYou extends StatefulWidget {
  @override
  _ThankYouState createState() => _ThankYouState();
}

class _ThankYouState extends State<ThankYou> {
  OrderModel _order;

  @override
  void didChangeDependencies() {
    _order = BlocProvider.of<OrderBloc>(context).order;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //Changing default hamburger menu icon
        title: Stack(
          children: [
            Text(
              'Eatstagram',
              style: TextStyle(
                color: Colors.black.withOpacity(0.9),
                fontFamily: 'Billabong',
                fontWeight: FontWeight.w500,
                fontSize: 28,
              ),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black.withOpacity(0.9)),
      ),
      body: Column(
        children: [
          //Title text
          Padding(
            padding: const EdgeInsets.only(top: 25.0),
            child: Text(
              'Enjoy your meal !',
              style: TextStyle(
                color: Colors.black.withOpacity(0.9),
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontSize: 32,
              ),
            ),
          ),

          // Description
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Container(
              height: 50,
              width: 280,
              child: Text(
                'Here\'s a summary of your order.',
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          ),

          // Order receipt card
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Order ID',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                        Container(
                          width: 120,
                          child: Text(
                            _order.id,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.blueGrey[800],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 10),

                    // Order Date
                    Column(
                      children: [
                        Text(
                          'Ordered On',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                        Text(
                          _order.time,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.blueGrey[800],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 10),

                    // Payment Method
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text(
                              'Table Number',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[600],
                              ),
                            ),
                            Text(
                              _order.table,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.blueGrey[800],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Paid',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                    Container(
                      width: 120,
                      child: Text(
                        '\$${roundCurrency(BlocProvider.of<CartBloc>(context).total, 2)}',
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          SizedBox(
            height: 50,
          ),

          RaisedButton(
            onPressed: () =>
                Navigator.of(context).pushReplacementNamed('/Menu'),
            child: Text('Order Again'),
          )
        ],
      ),
    );
  }
}
