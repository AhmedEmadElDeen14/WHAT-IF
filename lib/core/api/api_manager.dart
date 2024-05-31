import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:whatif_project/features/questions/data/remote/models/response_model.dart';
import 'package:whatif_project/features/story/data/models/clues_model.dart';


class ApiManager {



  Future getResponse(
      {required String apiKey,required CluesModel cluesModel}) async {


    final model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);
    final prompt =
    """
i i need you to create a story .
I'm making up a story called "What If?!" about ${cluesModel.topicTitle} and i'll give you situations didn't happened in real world and i need you to imagine what if this information happened in real world ? and give me a story about what you imagined and how did each of this events affect the other? and Make this story realistic and a good way to narrate the events  and give me details  .
these are situations don't real :  
${cluesModel.clue1}, ${cluesModel.clue2}, ${cluesModel.clue3}, ${cluesModel.clue4}, ${cluesModel.clue5}
i don't want your response in points or in Different scenarios , but I want one story that includes all these imaginary events, I want a story whose events are interconnected and based on each other's outcomes. I want you to remember the change that occurred in the real world as a result of changing these five things, and the result of these events on their owners and on the world of football.
I want you to unleash the story and imagine events other than the ones I told you about. You can give new ideas that I never mentioned to make the story more interesting.Imagine the history that changed based on these events and mention it in the story. you can add anything to the story from your imagination, such as the Championships and the number of titles ? Or how many times did he win the League's top scorer? Can you also mention leages and clubs he played for?
I want you to mention in numbers the heroics and achievements in this imaginary story.
write this story in arabic
""";
    final content = [Content.text(prompt)];
    final response = await model.generateContent(content);
    ResponseModel res = ResponseModel(response: response.text.toString());
    return res;
  }
}
