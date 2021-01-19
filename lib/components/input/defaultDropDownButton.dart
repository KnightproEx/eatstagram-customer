import 'package:flutter/material.dart';

class DefaultDropDownButton extends StatefulWidget {
  final List<String> _itemList;
  final Function(String value) onChanged;

  DefaultDropDownButton(
    this._itemList, {
    this.onChanged,
  });

  @override
  _DefaultDropDownButtonState createState() => _DefaultDropDownButtonState();
}

class _DefaultDropDownButtonState extends State<DefaultDropDownButton> {
  String _dropDownValue;

  @override
  void didChangeDependencies() {
    _dropDownValue = widget._itemList[0];
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: _dropDownValue,
      icon: Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(color: Colors.black87),
      underline: Container(
        height: 2,
        color: Colors.black87,
      ),
      onChanged: (String newValue) {
        setState(() => _dropDownValue = newValue);
        widget.onChanged(newValue);
      },
      items: widget._itemList
          .map((value) => DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              ))
          .toList(),
    );
  }
}
