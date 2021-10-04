import 'package:flutter/material.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';

numberTriviaDisplay(double containerHeight, NumberTrivia numberTrivia) {
  return SizedBox(
    height: containerHeight,
    child: Column(
      children: <Widget>[
        Text(
          numberTrivia.number.toString(),
          style: const TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.bold,
          ),
        ),
        Expanded(
          child: Center(
            child: SingleChildScrollView(
              child: Text(
                numberTrivia.text,
                style: const TextStyle(fontSize: 25),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        )
      ],
    ),
  );
}
