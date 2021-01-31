import '../../blocs/cart_bloc/cart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/payment_bloc/payment_bloc.dart';
import '../../components/appbar/default_appbar.dart';
import '../../components/snackbar/default_snackbar.dart';
import 'payment_ui.dart';

class Payment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(),
      body: BlocConsumer<PaymentBloc, PaymentState>(
        listenWhen: (_, current) =>
            current is PaymentError || current is PaymentSuccess,
        buildWhen: (_, current) => current is! PaymentError,
        listener: (context, state) {
          if (state is PaymentError) {
            Scaffold.of(context).showSnackBar(
              defaultSnackBar(state.message),
            );
          }

          if (state is PaymentSuccess) {
            Navigator.of(context).pushNamedAndRemoveUntil(
              '/OrderStatus',
              ModalRoute.withName('/Menu'),
            );

            BlocProvider.of<CartBloc>(context).add(EmptyCart());
          }
        },
        builder: (_, state) => state is PaymentLoading
            ? Center(child: CircularProgressIndicator())
            : PaymentUI(),
      ),
    );
  }
}
