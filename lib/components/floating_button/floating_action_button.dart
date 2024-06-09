import 'package:flutter/material.dart';


// ignore: must_be_immutable
class FloatingActionButtonCustom extends StatelessWidget {
  void Function()? onPressed;

  FloatingActionButtonCustom({
    super.key,
    required this.onPressed,
  });


  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 134, 201, 72),
        foregroundColor: Colors.black87,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: onPressed,
        child: const Icon(Icons.add),
      );
  }
}