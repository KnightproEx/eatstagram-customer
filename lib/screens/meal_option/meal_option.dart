import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/meal_option_bloc.dart';
import 'meal_option_ui.dart';

class MealOption extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MealOptionBloc(),
      child: MealOptionUI(),
    );
  }
}
