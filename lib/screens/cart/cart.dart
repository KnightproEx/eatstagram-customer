import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/cart_bloc/cart_bloc.dart';
import '../../components/snackbar/defaultSnackbar.dart';
import 'cart_appbar.dart';
import 'cart_ui.dart';

class Cart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CartAppBar(),
      body: BlocConsumer<CartBloc, CartState>(
        buildWhen: (_, current) => current is CartLoaded,
        listenWhen: (_, current) =>
            current is CartError || current is CartSubmitted,
        listener: (context, state) {
          if (state is CartError) {
            Scaffold.of(context).showSnackBar(
              defaultSnackBar(state.message),
            );
          }

          if (state is CartSubmitted) {
            Navigator.of(context).pushNamed('/Payment');
          }
        },
        builder: (_, __) => CartUI(),
      ),
    );
  }
}
