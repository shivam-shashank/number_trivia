import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_trivia/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:number_trivia/features/number_trivia/presentation/widgets/circular_loading.dart';
import 'package:number_trivia/features/number_trivia/presentation/widgets/message_display.dart';
import 'package:number_trivia/features/number_trivia/presentation/widgets/number_trivia_display.dart';

class NumberTriviaPage extends StatelessWidget {
  const NumberTriviaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _containerHeight = MediaQuery.of(context).size.height / 3;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Number Trivia'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 10),
              BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
                builder: (context, state) {
                  if (state is Empty) {
                    return messageDisplay(_containerHeight, "Start Searching!");
                  } else if (state is Loading) {
                    return circularLoader(_containerHeight);
                  } else if (state is Loaded) {
                    return numberTriviaDisplay(
                        _containerHeight, state.numberTrivia);
                  } else if (state is Error) {
                    return messageDisplay(_containerHeight, state.errorMessage);
                  } else {
                    return messageDisplay(_containerHeight, "Unknown Error!");
                  }
                },
              ),
              const SizedBox(height: 20),
              Column(
                children: <Widget>[
                  Placeholder(fallbackHeight: 40),
                  SizedBox(height: 10),
                  Row(
                    children: <Widget>[
                      Expanded(
                        // Search concrete button
                        child: Placeholder(fallbackHeight: 30),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        // Random button
                        child: Placeholder(fallbackHeight: 30),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
