import 'dart:convert';

import 'package:dev_quiz/shared/models/question_model.dart';

enum Level { facil, medio, dificil, perito }

//criar mapeamento do tipo para ENUM
extension StringToLevelExt on String {
  Level get parse => {
        "facil": Level.facil,
        "medio": Level.medio,
        "dificil": Level.dificil,
        "perito": Level.perito,
      }[this]!;
}

//criar mapeamento de enum para string
extension LevelToStringExt on Level {
  String get parse => {
        Level.facil: "facil",
        Level.medio: "medio",
        Level.dificil: "dificil",
        Level.perito: "perito",
      }[this]!;
}

class QuizModel {
  final Level level;
  final String image;
  final String title;
  final int questionAnswered;
  final List<QuestionModel> questions;

  QuizModel({
    required this.level,
    required this.image,
    required this.title,
    this.questionAnswered = 0,
    required this.questions,
  });

  Map<String, dynamic> toMap() {
    return {
      'level': level.parse,
      'image': image,
      'title': title,
      'questionAnswered': questionAnswered,
      'questions': questions.map((x) => x.toMap()).toList(),
    };
  }

  factory QuizModel.fromMap(Map<String, dynamic> map) {
    return QuizModel(
      level: map['level'].toString().parse,
      image: map['image'],
      title: map['title'],
      questionAnswered: map['questionAnswered'],
      questions: List<QuestionModel>.from(
          map['questions']?.map((x) => QuestionModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory QuizModel.fromJson(String source) =>
      QuizModel.fromMap(json.decode(source));
}
