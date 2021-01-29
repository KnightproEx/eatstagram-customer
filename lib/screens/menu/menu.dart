import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/snackbar/default_snackbar.dart';
import '../menu/bloc/menu_bloc.dart';
import '../menu/menu_appbar.dart';
import 'menu_drawer.dart';
import 'menu_ui.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MenuBloc(),
      child: Scaffold(
        drawer: MenuDrawer(),
        appBar: MenuAppBar(),
        body: BlocListener<MenuBloc, MenuState>(
          listenWhen: (_, current) =>
              current is MenuError || current is MenuLoaded,
          listener: (context, state) {
            if (state is MenuError) {
              Scaffold.of(context).showSnackBar(
                defaultSnackBar(state.message),
              );
            }
          },
          child: MenuUI(),
        ),
      ),
    );
  }
}
