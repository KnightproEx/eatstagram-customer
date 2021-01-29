import 'package:flutter/material.dart';

class DefaultCircleAvatar extends StatelessWidget {
  final String source;
  final double radius;

  DefaultCircleAvatar(
    this.source,
    this.radius,
  );

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundImage: NetworkImage(source),
    );
  }
}
