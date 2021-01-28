import 'package:flutter/material.dart';

class DefaultDropDown extends StatefulWidget {
  final List<String> _itemList;
  final Function(String value) onChanged;

  DefaultDropDown(
    this._itemList, {
    this.onChanged,
  });

  @override
  _DefaultDropDownState createState() => _DefaultDropDownState();
}

class _DefaultDropDownState extends State<DefaultDropDown> {
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
