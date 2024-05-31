import 'package:dartz/dartz.dart';
import 'package:whatif_project/core/errors/failure.dart';
import 'package:whatif_project/features/questions/data/remote/models/response_model.dart';
import 'package:whatif_project/features/story/data/models/clues_model.dart';

abstract class QuestionsRemoteDS{

  Future<Either<Failures, ResponseModel>> getResponse(CluesModel questionModel);

}