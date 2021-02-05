part of 'menu_bloc.dart';

abstract class MenuEvent extends Equatable {
  const MenuEvent();

  @override
  List<Object> get props => [];
}

class FetchMenu extends MenuEvent {
  final String _id;

  FetchMenu(this._id);

  @override
  List<Object> get props => [_id];
}

class SearchMenu extends MenuEvent {
  final String _search;

  SearchMenu(this._search);

  @override
  List<Object> get props => [_search];
}

class FilterMenu extends MenuEvent {
  final String _category;

  FilterMenu(this._category);

  @override
  List<Object> get props => [_category];
}
