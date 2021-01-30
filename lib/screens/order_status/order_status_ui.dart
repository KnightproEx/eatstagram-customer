import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../../blocs/order_bloc/order_bloc.dart';
import '../../blocs/payment_bloc/payment_bloc.dart';
import '../../models/order_model.dart';

class OrderStatusUI extends StatefulWidget {
  @override
  _OrderStatusUIState createState() => _OrderStatusUIState();
}

class _OrderStatusUIState extends State<OrderStatusUI> {
  final List<String> orderStatus = [
    "Order Received",
    "Preparing Order",
    "Order Delivered"
  ];

  final List<IconData> orderStatusIcons = [
    Icons.check_circle,
    Icons.local_fire_department_outlined,
    Icons.fastfood_rounded,
  ];

  Timer timer;
  String id;
  OrderBloc _orderBloc;
  OrderModel _order;

  @override
  void initState() {
    timer = Timer.periodic(
      Duration(seconds: 5),
      (_) => _orderBloc.add(FetchOrder(id)),
    );

    super.initState();
  }

  @override
  void didChangeDependencies() {
    _orderBloc = BlocProvider.of<OrderBloc>(context);
    _order = _orderBloc.order;

    id = BlocProvider.of<PaymentBloc>(context).orderID;
    _orderBloc.add(FetchOrder(id));

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderBloc, OrderState>(
      buildWhen: (_, current) => current is OrderLoaded,
      listenWhen: (_, current) => current is OrderLoaded,
      listener: (context, state) {
        if (state is OrderLoaded) {
          _order = state.order;
        }

        if (state is OrderLoaded && state.order.status == 3) {
          timer?.cancel();

          Navigator.of(context).pushReplacementNamed('/ThankYou');
        }
      },
      builder: (context, state) {
        if (state is OrderLoading) {
          return Center(child: CircularProgressIndicator());
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Page title
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Order Status',
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
            ),
            // Order details
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Placed On: ${_order.time}',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Order ID: ${_order.id}',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ),

            SizedBox(
              height: 25,
            ),

            // Order Received timeline
            TimelineTile(
              isFirst: true,
              alignment: TimelineAlign.manual,
              lineXY: 0.20,
              indicatorStyle: IndicatorStyle(
                color: Colors.blue,
              ),
              afterLineStyle: LineStyle(
                color: Colors.blue,
              ),
              endChild: Container(
                child: ListTile(
                  leading: Icon(
                    orderStatusIcons[0],
                    size: 40,
                    color: Colors.blue,
                  ),
                  title: Text(
                    orderStatus[0],
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                  subtitle: Text(
                    'Ready , set , go !',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),

            // Preparing timeline
            TimelineTile(
              alignment: TimelineAlign.manual,
              lineXY: 0.20,
              indicatorStyle: IndicatorStyle(
                color: _order.status >= 2 ? Colors.blue : Colors.grey,
              ),
              beforeLineStyle: LineStyle(
                color: _order.status >= 2 ? Colors.blue : Colors.grey,
              ),
              afterLineStyle: LineStyle(
                color: _order.status >= 2 ? Colors.blue : Colors.grey,
              ),
              endChild: Container(
                child: ListTile(
                  leading: Icon(
                    orderStatusIcons[1],
                    size: 40,
                    color:
                        _order.status >= 2 ? Colors.blue : Colors.blueGrey[800],
                  ),
                  title: Text(
                    orderStatus[1],
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                  subtitle: Text(
                    'Things are heating up ...',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),

            // Order Delivered timeline
            TimelineTile(
              isLast: true,
              alignment: TimelineAlign.manual,
              lineXY: 0.20,
              indicatorStyle: IndicatorStyle(
                color: _order.status >= 3 ? Colors.blue : Colors.grey,
              ),
              beforeLineStyle: LineStyle(
                color: _order.status >= 3 ? Colors.blue : Colors.grey,
              ),
              afterLineStyle: LineStyle(
                color: _order.status >= 3 ? Colors.blue : Colors.grey,
              ),
              endChild: Container(
                child: ListTile(
                  leading: Icon(
                    orderStatusIcons[2],
                    size: 40,
                    color:
                        _order.status >= 3 ? Colors.blue : Colors.blueGrey[800],
                  ),
                  title: Text(
                    orderStatus[2],
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                  subtitle: Text(
                    'Crossed the finish line !',
                    style: TextStyle(
                      fontSize: 15,
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
