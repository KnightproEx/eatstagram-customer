import 'package:flutter/material.dart';

class CartAppBar extends PreferredSize {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_rounded,
          color: Colors.black,
        ),
        onPressed: () => Navigator.pop(context),
        tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
      ),
    );
  }
}
