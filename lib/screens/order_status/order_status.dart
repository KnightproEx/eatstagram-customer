import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/order_bloc/order_bloc.dart';
import '../../components/appbar/default_appbar.dart';
import '../../components/snackbar/defaultSnackbar.dart';
import 'order_status_ui.dart';

class OrderStatus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(),
      body: BlocListener<OrderBloc, OrderState>(
        listenWhen: (_, current) =>
            current is OrderError || current is OrderLoaded,
        listener: (context, state) {
          if (state is OrderError) {
            Scaffold.of(context).showSnackBar(
              defaultSnackBar(state.message),
            );
          }
        },
        child: OrderStatusUI(),
      ),
    );
  }
}
