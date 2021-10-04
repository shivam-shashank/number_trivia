part of 'number_trivia_bloc.dart';

abstract class NumberTriviaEvent extends Equatable {
  const NumberTriviaEvent();
}

class GetConcreteNumberTriviaEvent extends NumberTriviaEvent {
  final String numberString;

  const GetConcreteNumberTriviaEvent(this.numberString);

  @override
  List<Object> get props => [numberString];
}

class GetRandomNumberTriviaEvent extends NumberTriviaEvent {
  @override
  List<Object> get props => [];
}
