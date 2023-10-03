import 'package:quizzler/main.dart';
import 'package:quizzler/questionBank.dart';
import 'questionBank.dart';
import 'Home.dart';
class Question {
  String? questionText;
  bool? questionAnswer;
  Question(String q, bool a) {
    questionText = q;
    questionAnswer = a;
  }
}

class QuizBrain {
  
// Tracking question no:----------------
  int _questionNumber = 0;
  // Score Counter:
  int _score = 0;

  bool isOver = false;
  // MAKING ARRAY OF OBJECTS OF QUESTIONS:
  // final List<Question> _questionBank = [
  //   Question('Can cow fly?', false),
  //   Question('Can humans Bark', true),
  //   Question('Are you a Devil', true)
  // ];



  // __________________DECLARING QUESTIONS_________________________
  final List<Question> _questionBank = questionBank;

  String? getQuestion() {
    return _questionBank[_questionNumber].questionText;
  }

  bool? getAnswer() {
    return _questionBank[_questionNumber].questionAnswer;
  }

  void nextQuestion(context) {
    if (_questionNumber == _questionBank.length - 1) {
      isOver = true;
      _questionNumber = 0;
    }
    if (_questionNumber < _questionBank.length - 1) {
      _questionNumber++;
    }
  }

  void scoreInc() {
    _score++;
  }

  bool isQuestionEnd() {
    return isOver;
  }

  void restart() {
    _questionNumber = 0;
    _score = 0;
    scoreKeeper = [];
    isOver = false;
  }

  int getScore() {
    return _score;
  }
  
  int getQuestionNumber()
  {
    return _questionNumber;
  }
  // bool quizEnd() {
  //   if (_questionNumber >= _questionBank.length-1) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }
}
