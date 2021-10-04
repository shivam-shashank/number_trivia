import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_trivia/features/number_trivia/presentation/pages/number_trivia_page.dart';

import 'features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'injection_container.dart' as di;
import 'injection_container.dart';

void main() async {
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: sl<NumberTriviaBloc>()),
      ],
      child: MaterialApp(
        title: 'Number Trivia',
        theme: ThemeData(
          primaryColor: Colors.green.shade800,
          accentColor: Colors.green.shade600,
        ),
        debugShowCheckedModeBanner: false,
        home: const NumberTriviaPage(),
      ),
    );
  }
}
