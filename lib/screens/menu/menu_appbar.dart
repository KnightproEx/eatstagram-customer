import 'package:flutter/material.dart';

class MenuAppBar extends PreferredSize {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: IconButton(
        // icon: Icon(Icons.account_circle_outlined),
        icon: Icon(Icons.menu),
        onPressed: () => Scaffold.of(context).openDrawer(),
        tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.shopping_cart,
            color: Colors.black.withOpacity(0.9),
          ),
          onPressed: () => Navigator.of(context).pushNamed('/Cart'),
        ),
      ],
      centerTitle: true,
      title: Text(
        'Eatstagram',
        style: TextStyle(
          color: Colors.black.withOpacity(0.9),
          fontFamily: 'Billabong',
          fontWeight: FontWeight.w500,
          fontSize: 28,
        ),
      ),
      // backgroundColor: Colors.white,
      // elevation: 5,
      iconTheme: IconThemeData(
        color: Colors.black.withOpacity(0.9),
      ),
    );
  }
}
