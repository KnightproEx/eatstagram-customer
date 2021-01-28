import 'dart:ui';

import 'package:flutter/material.dart';

class DefaultTextfield extends StatefulWidget {
  final String hintText;
  final IconData prefixIcon;
  final IconData suffixIcon;
  final bool isPassword;
  final Function validator;
  final TextEditingController controller;

  DefaultTextfield({
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.isPassword = false,
    this.validator,
    this.controller,
  });

  @override
  _DefaultTextfieldState createState() => _DefaultTextfieldState(isPassword);
}

class _DefaultTextfieldState extends State<DefaultTextfield> {
  bool _obscure;

  _DefaultTextfieldState(this._obscure);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      obscureText: _obscure,
      style: TextStyle(
        color: Colors.black87,
        fontSize: 18,
      ),
      cursorColor: Colors.grey[700],
      decoration: InputDecoration(
        labelText: widget.hintText,
        prefixIcon: Icon(
          widget.prefixIcon,
          color: Colors.grey[700],
        ),
        filled: true,
        enabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.black,
            width: 1.5,
          ),
        ),
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _obscure ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey[700],
                ),
                onPressed: () => setState(() => _obscure = !_obscure),
              )
            : Icon(widget.suffixIcon),
        labelStyle: TextStyle(
          color: Colors.grey[700],
        ),
      ),
    );
  }
}

class DefaultTextField2 extends StatelessWidget {
  final InputBorder inputBorder;
  final bool obscureText;
  final Function onChanged;
  final Function validator;
  final TextEditingController controller;
  final Color color;
  final bool enabled;

  DefaultTextField2({
    this.inputBorder,
    this.obscureText = false,
    this.onChanged,
    this.validator,
    this.controller,
    this.color,
    this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      onChanged: onChanged,
      obscureText: obscureText,
      enabled: enabled,
      style: TextStyle(
        color: color,
        fontSize: 16,
      ),
      cursorColor: Colors.grey[700],
      decoration: InputDecoration(
        border: inputBorder,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 1.5),
        ),
      ),
    );
  }
}
