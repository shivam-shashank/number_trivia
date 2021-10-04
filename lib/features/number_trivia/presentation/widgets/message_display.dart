import 'package:flutter/material.dart';

messageDisplay(double containerHeight, String displayMessage) {
  return SizedBox(
    height: containerHeight,
    child: Center(
      child: SingleChildScrollView(
        child: Text(
          displayMessage,
          style: const TextStyle(fontSize: 25),
          textAlign: TextAlign.center,
        ),
      ),
    ),
  );
}
