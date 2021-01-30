import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'meal_option_event.dart';

class MealOptionBloc extends Bloc<MealOptionEvent, bool> {
  bool _isTakeAway = false;
  String _dropDownValue = '';

  String get dropDownValue => _dropDownValue;

  MealOptionBloc() : super(false);

  @override
  Stream<bool> mapEventToState(MealOptionEvent event) async* {
    if (event is ToggleSwitch) {
      _isTakeAway = !_isTakeAway;
      yield _isTakeAway;
    }

    if (event is DropDownSelect) {
      _dropDownValue = event._dropDownValue;
    }
  }
}
