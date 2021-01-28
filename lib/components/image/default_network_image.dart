import 'package:flutter/material.dart';

class DefaultNetworkImage extends StatelessWidget {
  final String source;

  DefaultNetworkImage(this.source);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      source,
      fit: BoxFit.fill,
    );
  }
}
