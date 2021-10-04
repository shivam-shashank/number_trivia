import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:number_trivia/core/constants.dart';
import 'package:number_trivia/core/error/failure.dart';
import 'package:number_trivia/core/use_cases/use_case.dart';
import 'package:number_trivia/core/util/input_converter.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/use_cases/get_concrete_number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/use_cases/get_random_number_trivia.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcreteNumberTrivia getConcreteNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;
  final InputConverter inputConverter;

  NumberTriviaBloc({
    required this.getConcreteNumberTrivia,
    required this.getRandomNumberTrivia,
    required this.inputConverter,
  }) : super(Empty()) {
    on<NumberTriviaEvent>((event, emit) {
      // TODO: implement event handler
    });
  }

  @override
  Stream<NumberTriviaState> mapEventToState(
    NumberTriviaEvent event,
  ) async* {
    if (event is GetConcreteNumberTriviaEvent) {
      final inputEither =
          inputConverter.stringToUnsignedInteger(event.numberString);

      yield* inputEither.fold(
        (failure) async* {
          yield const Error(errorMessage: Constants.invalidInputFailureMessage);
        },
        (integer) async* {
          yield Loading();
          final failureOrTrivia = await getConcreteNumberTrivia(
            Params(number: integer),
          );
          yield* _eitherLoadedOrErrorState(failureOrTrivia);
        },
      );
    } else if (event is GetRandomNumberTrivia) {
      yield Loading();
      final failureOrTrivia = await getRandomNumberTrivia(NoParams());
      yield* _eitherLoadedOrErrorState(failureOrTrivia);
    }
  }
}

Stream<NumberTriviaState> _eitherLoadedOrErrorState(
  Either<Failure, NumberTrivia> either,
) async* {
  yield either.fold(
    (failure) => Error(errorMessage: _mapFailureToMessage(failure)),
    (numberTrivia) => Loaded(numberTrivia: numberTrivia),
  );
}

String _mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return Constants.serverFailureMessage;
    case CacheFailure:
      return Constants.cacheFailureMessage;
    default:
      return Constants.unexpectedError;
  }
}
