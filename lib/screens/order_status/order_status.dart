import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/order_bloc/order_bloc.dart';
import '../../components/appbar/default_appbar.dart';
import '../../components/snackbar/default_snackbar.dart';
import 'order_status_ui.dart';

class OrderStatus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool loaded = false;

    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        appBar: DefaultAppBar(backButton: false),
        body: BlocConsumer<OrderBloc, OrderState>(
          buildWhen: (_, current) => current is! OrderError,
          listenWhen: (_, current) =>
              current is OrderError || current is OrderLoaded,
          listener: (context, state) {
            if (state is OrderError) {
              Scaffold.of(context).showSnackBar(
                defaultSnackBar(state.message),
              );
            }
          },
          builder: (context, state) {
            if (state is OrderLoading && !loaded) {
              loaded = true;
              return Center(child: CircularProgressIndicator());
            }

            return OrderStatusUI();
          },
        ),
      ),
    );
  }
}
