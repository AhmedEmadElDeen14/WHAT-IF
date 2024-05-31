import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:whatif_project/core/enum/screen_state.dart';
import 'package:whatif_project/core/errors/failure.dart';
import 'package:whatif_project/features/questions/data/remote/models/response_model.dart';
import 'package:whatif_project/features/questions/domain/use_cases/get_response_use_case.dart';
import 'package:whatif_project/features/story/data/models/clues_model.dart';

part 'question_event.dart';
part 'question_state.dart';

class QuestionBloc extends Bloc<QuestionEvent, QuestionState> {

  GetResponseUseCase getResponseUseCase;
  CluesModel cluesModel;


  QuestionBloc(this.getResponseUseCase,this.cluesModel) : super(QuestionInitial()) {
    on<QuestionEvent>((event, emit) async {
      if (event is QuestionGetResponse){
        emit(state.copyWith(type: ScreenType.loading));
        print("1----------------------------");
        var res = await getResponseUseCase.call(cluesModel);
        res.fold((l)  {
          print("77----------------------------");
          emit(state.copyWith(type: ScreenType.failures,failures: l));
        }, (r) {
          print("66----------------------------");
          emit(state.copyWith(type: ScreenType.success,responseModel: r));
        });
      }
    });
  }
}
