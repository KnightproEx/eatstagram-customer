part of 'meal_option_bloc.dart';

abstract class MealOptionEvent extends Equatable {
  const MealOptionEvent();

  @override
  List<Object> get props => [];
}

class ToggleSwitch extends MealOptionEvent {}

class DropDownSelect extends MealOptionEvent {
  final String _dropDownValue;

  DropDownSelect(this._dropDownValue);

  @override
  List<Object> get props => [_dropDownValue];
}
