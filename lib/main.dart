import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'questions.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'dart:async';

QuizQuestions quizQuestions = QuizQuestions();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: EdgeInsets.zero,
          child: QuizApp(),
        ),
      ),
    );
  }
}

class QuizApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<QuizApp> {
  int finalScore = 0;
  List<Widget> score = [];

  void checkAnswer(bool userAnswer) {
    bool answer = quizQuestions.getQuestionAnswer();

    setState(() {
      if (quizQuestions.quizFinished() == true) {
        Alert(
          context: context,
          title: 'Completed!',
          desc: 'Your score is $finalScore',
        ).show();
        quizQuestions.reset();
        score = [];
        finalScore = 0;
        start = 0;
        timer.cancel();
      } else {
        if (userAnswer == answer) {
          score.add(
            Icon(
              Icons.check,
              color: Colors.white,
              size: 50,
            ),
          );
          finalScore++;
        } else {
          score.add(
            Icon(
              Icons.close,
              color: Colors.red,
              size: 50,
            ),
          );
        }
        quizQuestions.nextQuestion();
      }
    });
  }

  late Timer timer;
  int start = 0;

  void myTimer() {
    const sec = const Duration(seconds: 1);
    timer = Timer.periodic(
      sec,
      (Timer timer) {
        // setState(() {
        if (start == 10) {
          setState(() {
            Alert(
              context: context,
              title: 'Time Over!',
              desc: 'Your score is $finalScore',
            ).show();
            quizQuestions.reset();
            score = [];
            finalScore = 0;
            start = 0;
            timer.cancel();
          });
        } else {
          setState(() {
            start++;
          });
        }
        // });
      },
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    const Color(0xFF7042A9),
                    const Color(0xFF8B52D1),
                  ],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Questions ${quizQuestions.questionNum()} of 18',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                Text(
                  quizQuestions.getQuestionText(),
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                Container(
                  height: 40,
                  width: 120,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.yellow,
                          offset: Offset(
                            0.0,
                            0.0,
                          ),
                          blurRadius: 14.0,
                          spreadRadius: 2.0,
                        ),
                      ],
                      color: Color(0xffFFDD00),
                      border: Border.all(
                        color: Colors.transparent,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.timer_outlined,
                        color: Colors.white,
                        size: 25,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        '$start',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xffFDFCF9),
                      onPrimary: Colors.white,
                      shadowColor: Colors.greenAccent,
                      elevation: 7,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      minimumSize: Size(500, 60),
                    ),
                    child: Text(
                      'True',
                      style: TextStyle(
                        color: Color(0xff525252),
                        fontSize: 20,
                      ),
                    ),
                    onPressed: () {
                      if (start == 0) {
                        myTimer();
                      }
                      checkAnswer(true);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xffFDFCF9),
                      onPrimary: Colors.white,
                      shadowColor: Colors.greenAccent,
                      elevation: 7,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      minimumSize: Size(500, 60),
                    ),
                    child: Text(
                      'False',
                      style: TextStyle(
                        color: Color(0xff525252),
                        fontSize: 20,
                      ),
                    ),
                    onPressed: () {
                      if (start == 0) {
                        myTimer();
                      }
                      checkAnswer(false);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  child: Container(
                    constraints: BoxConstraints(
                      minHeight: 55,
                      minWidth: 500,
                    ),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.greenAccent,
                          offset: Offset(
                            0.0,
                            0.0,
                          ),
                          blurRadius: 5.0,
                          spreadRadius: 2.0,
                        ),
                      ],
                      color: Color(0xff8B52D1),
                      border: Border.all(
                        color: Colors.transparent,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: SingleChildScrollView(
                      reverse: true,
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: score,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
