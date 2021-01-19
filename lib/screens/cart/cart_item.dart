import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/cart_bloc/cart_bloc.dart';
import '../../models/menu_model.dart';
import '../../utils/round_number.dart';

class CartItem extends StatefulWidget {
  final MenuModel _menu;
  final int _quantity;

  const CartItem(
    this._menu,
    this._quantity,
  );

  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  CartBloc _cartBloc;

  @override
  void didChangeDependencies() {
    _cartBloc = BlocProvider.of<CartBloc>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final MenuModel _menu = widget._menu;
    final int _quantity = widget._quantity;

    return Column(
      children: [
        Container(
          height: 120,
          width: double.maxFinite,
          child: Card(
            elevation: 2,
            child: Stack(
              children: [
                // Circle Image
                Positioned(
                  top: 15,
                  left: 10,
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(
                      _menu.imagePath,
                    ),
                  ),
                ),

                // Item name, description and price
                Positioned(
                  left: 120,
                  top: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _menu.name,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        _menu.desc,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        '\$${roundCurrency(_menu.price, 2)}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                // Cancel and quantity buttons
                Positioned(
                  right: 1,
                  top: 1,
                  child: IconButton(
                    icon: Icon(Icons.close_rounded),
                    splashRadius: 20.0,
                    onPressed: () => _cartBloc.add(RemoveItem(_menu.id)),
                  ),
                ),
                Positioned(
                  right: 45,
                  top: 40,
                  child: Container(
                    width: 30.0,
                    child: Text(
                      '$_quantity',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Positioned(
                  top: 30,
                  right: 60,
                  child: IconButton(
                    icon: Icon(Icons.expand_less),
                    iconSize: 35,
                    splashRadius: 20.0,
                    onPressed: () => _cartBloc.add(ItemIncrement(_menu.id)),
                  ),
                ),
                Positioned(
                  top: 30,
                  right: 10,
                  child: IconButton(
                    icon: Icon(Icons.expand_more),
                    iconSize: 35,
                    splashRadius: 20.0,
                    onPressed: () => setState(
                      () => _cartBloc.add(ItemDecrement(_menu.id)),
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
