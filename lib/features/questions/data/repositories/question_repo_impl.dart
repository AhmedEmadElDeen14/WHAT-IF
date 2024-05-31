import 'package:dartz/dartz.dart';
import 'package:whatif_project/core/errors/failure.dart';
import 'package:whatif_project/features/questions/data/remote/data_sources/question_remote_ds.dart';
import 'package:whatif_project/features/questions/data/remote/models/response_model.dart';
import 'package:whatif_project/features/questions/domain/repositories/question_repo.dart';
import 'package:whatif_project/features/story/data/models/clues_model.dart';

class QuestionRepoImpl extends QuestionRepo{

  QuestionsRemoteDS questionsRemoteDS;

  QuestionRepoImpl(this.questionsRemoteDS);

  @override
  Future<Either<Failures, ResponseModel>> getResponse(CluesModel questionModel) {
    print("2------------------------------------------------");
    return questionsRemoteDS.getResponse(questionModel);
  }
  
}