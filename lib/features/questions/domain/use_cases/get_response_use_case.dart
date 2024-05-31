import 'package:dartz/dartz.dart';
import 'package:whatif_project/core/errors/failure.dart';
import 'package:whatif_project/features/questions/data/remote/models/response_model.dart';
import 'package:whatif_project/features/questions/domain/repositories/question_repo.dart';
import 'package:whatif_project/features/story/data/models/clues_model.dart';

class GetResponseUseCase {
  QuestionRepo questionRepo;

  GetResponseUseCase(this.questionRepo);

  Future<Either<Failures, ResponseModel>> call(CluesModel questionModel) =>
      questionRepo.getResponse(questionModel);
}
