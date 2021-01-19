import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/restaurant_bloc/restaurant_bloc.dart';
import '../../components/appbar/default_appbar.dart';
import '../../components/snackbar/defaultSnackbar.dart';
import 'scanner_ui.dart';

class Scanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(),
      body: BlocConsumer<RestaurantBloc, RestaurantState>(
        buildWhen: (_, current) => current is! RestaurantError,
        listenWhen: (_, current) =>
            current is RestaurantError || current is RestaurantLoaded,
        listener: (context, state) {
          if (state is RestaurantError) {
            Scaffold.of(context).showSnackBar(
              defaultSnackBar(state.message),
            );
          }

          if (state is RestaurantLoaded) {
            Navigator.of(context).pushNamed('/Restaurant');
          }
        },
        builder: (_, state) {
          if (state is RestaurantLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return ScannerUI();
        },
      ),
    );
  }
}
