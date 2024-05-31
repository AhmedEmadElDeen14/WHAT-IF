part of 'question_bloc.dart';

@immutable
class QuestionState {
  ScreenType? type;
  Failures? failures;
  ResponseModel? responseModel;

  QuestionState({this.type, this.failures, this.responseModel});

  QuestionState copyWith(
      {ScreenType? type, Failures? failures, ResponseModel? responseModel}) {
    return QuestionState(
      type: type ?? this.type,
      failures: failures ?? this.failures,
      responseModel: responseModel ?? this.responseModel,
    );
  }
}

class QuestionInitial extends QuestionState {
  QuestionInitial() : super(type: ScreenType.init);
}
