import 'package:flutter/material.dart';


// ignore: must_be_immutable
class TextInput extends StatelessWidget {
  TextEditingController controller;
  String labelText;
  Icon icon;

  TextInput(
      {super.key,
      required this.controller,
      required this.labelText,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.white10, width: 1.0)),
          labelText: labelText,
          labelStyle: const TextStyle(color: Colors.grey),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey)),
          suffixIcon: icon,
          fillColor: Colors.grey[800],
          filled: true,
        ),
        keyboardType: TextInputType.text,
        style: TextStyle(
          color: Colors.grey[300],
        ),
      ),
    );
  }
}
