import 'package:flutter/material.dart';

Widget inputWidget(
    {@required label, @required hintText, @required controller}) {
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

Widget buttonWidget(
    {@required label, @required colorButton, @required onPress}) {
  return GestureDetector(
    onTap: onPress,
    child: Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.only(top: 15, bottom: 15, right: 40, left: 40),
      decoration: BoxDecoration(
          color: colorButton, borderRadius: BorderRadius.circular(10)),
      child: Text(label,
          style: const TextStyle(color: Colors.black, fontSize: 15)),
    ),
  );
}
