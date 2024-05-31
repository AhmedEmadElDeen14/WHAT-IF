import 'package:dartz/dartz.dart';
import 'package:whatif_project/core/api/api_manager.dart';
import 'package:whatif_project/core/errors/failure.dart';
import 'package:whatif_project/core/utils/constants.dart';
import 'package:whatif_project/features/questions/data/remote/data_sources/question_remote_ds.dart';
import 'package:whatif_project/features/questions/data/remote/models/response_model.dart';
import 'package:whatif_project/features/story/data/models/clues_model.dart';

class QuestionsRemoteDSImpl extends QuestionsRemoteDS {
  ApiManager apiManager;

  QuestionsRemoteDSImpl(this.apiManager);

  @override
  Future<Either<Failures, ResponseModel>> getResponse(CluesModel cluesModel) async{
    try{
      ResponseModel response = await apiManager.getResponse(apiKey: Constants.apiKey, cluesModel: cluesModel);
      print("3--------------------------------------------------");
      return right(response);
    }catch (e){
      return left(RemoteFailure(e.toString()));
    }
  }

}