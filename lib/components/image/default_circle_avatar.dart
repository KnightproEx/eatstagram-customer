import 'package:flutter/material.dart';

class DefaultCircleAvatar extends StatefulWidget {
  final String source;
  final double radius;

  DefaultCircleAvatar(
    this.source,
    this.radius,
  );

  @override
  _DefaultCircleAvatarState createState() => _DefaultCircleAvatarState();
}

class _DefaultCircleAvatarState extends State<DefaultCircleAvatar> {
  bool _loaded = true;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: widget.radius,
      backgroundImage: _loaded
          ? NetworkImage(widget.source)
          : AssetImage('assets/images/circle_avatar_error.png'),
      onBackgroundImageError: (exception, stackTrace) =>
          setState(() => _loaded = false),
    );
  }
}
