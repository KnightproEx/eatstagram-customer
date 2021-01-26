import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../blocs/cart_bloc/cart_bloc.dart';
import '../../models/menu_model.dart';

class MenuBottomSheet extends StatefulWidget {
  final MenuModel _menu;

  const MenuBottomSheet(this._menu);

  @override
  _MenuBottomSheetState createState() => _MenuBottomSheetState();
}

class _MenuBottomSheetState extends State<MenuBottomSheet> {
  int _count = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      child: Wrap(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Align(
              alignment: Alignment.topCenter,
              child: Text(
                'Select Quantity',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w100,
                    color: Colors.black),
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.expand_less),
                    splashRadius: 20.0,
                    onPressed: () => setState(() => _count++),
                  ),
                  Text(
                    _count.toString(),
                    style: TextStyle(
                      fontSize: 50,
                      color: Colors.blueGrey[800],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.expand_more,
                    ),
                    splashRadius: 20.0,
                    onPressed: () =>
                        setState(() => _count += _count <= 1 ? 0 : 1),
                  )
                ],
              )),
          Align(
            alignment: Alignment.bottomCenter,
            child: ButtonTheme(
              height: 40,
              minWidth: 180,
              buttonColor: HexColor('#2f2f2f'),
              textTheme: ButtonTextTheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(30),
                ),
              ),
              child: RaisedButton(
                onPressed: () {
                  BlocProvider.of<CartBloc>(context).add(
                    AddItem(widget._menu, _count),
                  );

                  Flushbar(
                    message: 'Item added to cart',
                    reverseAnimationCurve: Curves.decelerate,
                    forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
                    icon: Icon(
                      Icons.add_shopping_cart_outlined,
                      color: Colors.white.withOpacity(0.9),
                    ),
                    duration: Duration(seconds: 2),
                  ).show(context);
                },
                child: Text('Add To Cart'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
