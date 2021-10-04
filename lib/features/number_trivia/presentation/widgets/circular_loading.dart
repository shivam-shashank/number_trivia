import 'package:flutter/material.dart';

circularLoader(double containerHeight) {
  return SizedBox(
    height: containerHeight,
    child: const Center(
      child: CircularProgressIndicator(),
    ),
  );
}
