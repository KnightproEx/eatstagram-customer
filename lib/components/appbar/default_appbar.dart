import 'package:flutter/material.dart';

class DefaultAppBar extends PreferredSize {
  final bool backButton;

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  DefaultAppBar({this.backButton = true});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: backButton
          ? InkWell(
              child: Icon(Icons.arrow_back),
              onTap: () => Navigator.pop(context),
            )
          : Container(),
    );
  }
}
