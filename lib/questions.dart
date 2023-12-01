class Question {
  late String questionText;
  late bool questionAnswer;

  Question(this.questionText, this.questionAnswer);
}

class QuizQuestions {
  int _questionNumber = 0;

  List<Question> _quizQuestions = [
    Question('The earth is the fourth planet from the sun.', false),
    Question('The planet Venus has no moons.', true),
    Question('Jupiter is composed mostly of iron.', false),
    Question('The sun is a star of average size.', true),
    Question('A lunar eclipse occurs when the sun passes', false),
    Question('Milk is 87% water.', true),
    Question('The ostrich has the largest eye in the world.', false),
    Question('YouTube was founded on Valentine’s Day.', true),
    Question('New Zealand has more sheep than people.', true),
    Question('The Sahara desert spans twelve different countries.', true),
    Question('Dry skin only happens in the winter.', false),
    Question('Peanuts are not nuts!', true),
    Question('Electrons move faster than the speed of light.', false),
    Question('There is no snow on Minecraft.', false),
    Question('Light travels in a straight line.', true),
    Question('There are three rivers in Saudi Arabia.', false),
    Question('The Great Wall of China is visible from space.', false),
    Question('There are more ancient pyramids in Sudan than in Egypt.', true),
  ];

  void nextQuestion() {
    if (_questionNumber < _quizQuestions.length - 1) {
      _questionNumber++;
    }
  }

  String getQuestionText() {
    return _quizQuestions[_questionNumber].questionText;
  }

  bool getQuestionAnswer() {
    return _quizQuestions[_questionNumber].questionAnswer;
  }

  bool quizFinished() {
    if (_questionNumber >= _quizQuestions.length - 1) {
      return true;
    } else {
      return false;
    }
  }

  int questionNum() {
    int qNum = _questionNumber + 1;
    return qNum;
  }

  void reset() {
    _questionNumber = 0;
  }
}
