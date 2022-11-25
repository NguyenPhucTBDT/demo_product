import 'package:flutter/material.dart';
Widget inputWidget({@required label,@required hintText,@required controller}) {
  return Container(
    padding: const EdgeInsets.all(10),
      child: TextField(
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: label,
          hintText: hintText,
        ),
        controller: controller,
      ),
  );
}