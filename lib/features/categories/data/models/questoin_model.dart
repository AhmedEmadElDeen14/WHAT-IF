class QuestionModel {
  String question;
  String? choiceOne;
  String? choiceTwo;

  QuestionModel({
    required this.question,
    String? choiceOne,
    String? choiceTwo,
  })  : choiceOne = choiceOne ?? "Yes",
        choiceTwo = choiceTwo ?? "No";

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      question: json['question'],
      choiceOne: json['choiceOne'],
      choiceTwo: json['choiceTwo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'question': question,
      'choiceOne': choiceOne,
      'choiceTwo': choiceTwo,
    };
  }
}
