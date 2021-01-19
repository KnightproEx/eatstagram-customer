import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/cart_bloc/cart_bloc.dart';
import 'blocs/order_bloc/order_bloc.dart';
import 'blocs/payment_bloc/payment_bloc.dart';
import 'blocs/restaurant_bloc/restaurant_bloc.dart';
import 'route.dart';
import 'theme/default.dart';

void main() => runApp(Eatstagram());

class Eatstagram extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return MultiBlocProvider(
      providers: [
        BlocProvider<RestaurantBloc>(
          create: (_) => RestaurantBloc(),
        ),
        BlocProvider<CartBloc>(
          create: (_) => CartBloc(),
        ),
        BlocProvider<PaymentBloc>(
          create: (_) => PaymentBloc(),
        ),
        BlocProvider<OrderBloc>(
          create: (_) => OrderBloc(),
        ),
      ],
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: MaterialApp(
          title: 'List',
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          routes: routes,
          theme: defaultTheme,
        ),
      ),
    );
  }
}
