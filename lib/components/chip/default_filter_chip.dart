import 'package:flutter/material.dart';

class DefaultFilterChip extends StatefulWidget {
  final String text;
  final Function(bool) onSelected;

  const DefaultFilterChip({@required this.text, this.onSelected});

  @override
  _DefaultFilterChipState createState() => _DefaultFilterChipState();
}

class _DefaultFilterChipState extends State<DefaultFilterChip> {
  bool _selected = false;
  @override
  Widget build(BuildContext context) {
    return FilterChip(
      selected: _selected,
      label: Text(widget.text),
      onSelected: (selected) {
        widget.onSelected(selected);
        setState(() => _selected = !_selected);
      },
    );
  }
}
