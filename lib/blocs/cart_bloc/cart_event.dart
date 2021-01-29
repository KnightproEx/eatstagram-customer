part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class EmptyCart extends CartEvent {}

class AddItem extends CartEvent {
  final MenuModel _menu;
  final int _quantity;

  AddItem(
    this._menu,
    this._quantity,
  );

  @override
  List<Object> get props => [_menu, _quantity];
}

class ItemIncrement extends CartEvent {
  final String _id;

  ItemIncrement(this._id);

  @override
  List<Object> get props => [_id];
}

class ItemDecrement extends CartEvent {
  final String _id;

  ItemDecrement(this._id);

  @override
  List<Object> get props => [_id];
}

class RemoveItem extends CartEvent {
  final String _id;

  RemoveItem(this._id);

  @override
  List<Object> get props => [_id];
}

class CheckOut extends CartEvent {}
