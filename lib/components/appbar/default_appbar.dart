import 'package:flutter/material.dart';

class DefaultAppBar extends PreferredSize {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: InkWell(
        child: Icon(Icons.arrow_back),
        onTap: () => Navigator.pop(context),
      ),
      // title: Text(
      //   'Eatstagram',
      //   style: TextStyle(
      //     color: Colors.black.withOpacity(0.9),
      //     fontFamily: 'Billabong',
      //     fontWeight: FontWeight.w500,
      //     fontSize: 28,
      //   ),
      // ),
      // centerTitle: true,
    );
  }
}
