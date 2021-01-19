part of 'menu_bloc.dart';

abstract class MenuState extends Equatable {
  @override
  List<Object> get props => [];
}

class MenuInitial extends MenuState {}

class MenuLoading extends MenuState {}

class MenuError extends MenuState {
  final String _message;

  MenuError(this._message);

  String get message => _message;

  @override
  List<Object> get props => [_message];
}

class MenuLoaded extends MenuState {
  final List<MenuModel> _menuList;

  MenuLoaded(this._menuList);

  List<MenuModel> get menuList => _menuList;

  @override
  List<Object> get props => [_menuList];
}

class MenuSearchLoaded extends MenuState {
  final List<MenuModel> _menuList;

  MenuSearchLoaded(this._menuList);

  List<MenuModel> get menuList => _menuList;

  @override
  List<Object> get props => [_menuList];
}
