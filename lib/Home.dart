
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:quizzler/Classes.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'questionBank.dart';


QuizBrain quizBrain = QuizBrain();

// ----------------------------------Icons Array------------------------------------

List<Icon> scoreKeeper = [];

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
// ------------------=---On Buttons:-----------------------------

    void checkAnswer(bool choosedAns) {
      if (quizBrain.getAnswer() == choosedAns) {
        quizBrain.scoreInc();
        scoreKeeper.add(const Icon(
          Icons.check,
          color: Colors.green,
        ));
      } else {
        scoreKeeper.add(const Icon(
          Icons.close,
          color: Colors.red,
        ));
      }

      quizBrain.nextQuestion(context);
    }

//------------------- Score Varaible--------------
    int score = quizBrain.getScore();
    int totalQuestion = questionBank.length;
    int questionNo = quizBrain.getQuestionNumber();
    double percentage = questionNo.toDouble() / totalQuestion.toDouble();
    // ------------------------_APP STARTING_--------------------------------
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                  width: 2,
                ),
                // ---------------circualr percentage-----------------------
                CircularPercentIndicator(
                  radius: 70,
                  lineWidth: 20,
                  percent: percentage,
                  progressColor: Colors.deepPurple,
                  backgroundColor: Colors.deepPurple.shade100,
                  circularStrokeCap: CircularStrokeCap.round,
                  center: Text(
                    '$score/$totalQuestion',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
                const SizedBox(
                  height: 100,
                  width: 50,
                ),
                Container(
                 height: 220,
                  child: Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        quizBrain.getQuestion() ?? "!NOT FOUND!",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                        ),
                      )),
                ),
                
//-------------------------------------- QUIT BUTTON----------------------------------
                ElevatedButton(
                  onPressed: () {
                    quizBrain.isOver = true;
                    setState(() {
                      Alert(
                          context: context,
                          type: AlertType.info,
                          title: "Quiz Over",
                          desc: "Score $score/$totalQuestion",
                          buttons: [
                            DialogButton(
                              onPressed: () {
                                setState(() {
                                  quizBrain.restart();
                                  Navigator.pop(context);
                                });
                              },
                              color: const Color.fromRGBO(0, 179, 134, 1.0),
                              child: const Text(
                                "Restart",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            )
                          ]).show();
                    });
                  },


                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                  ),
                  child: const Text(
                    'Quit',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),

                const SizedBox(
                  height: 30,
                  width: 30,
                ),

                Container(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                              child: SizedBox(
                                height: 60,
                                child: ElevatedButton(
                                                            onPressed: () {
                                setState(() {
                                  checkAnswer(true);
                                  if (quizBrain.isQuestionEnd()) {
                                    int score = quizBrain.getScore();
                                    Alert(
                                        context: context,
                                        type: AlertType.info,
                                        title: "Quiz Over",
                                        desc: "Score $score",
                                        buttons: [
                                          DialogButton(
                                            onPressed: () {
                                              setState(() {
                                                quizBrain.restart();
                                                Navigator.pop(context);
                                              });
                                            },
                                            color: const Color.fromRGBO(
                                                0, 179, 134, 1.0),
                                            child: const Text(
                                              "Restart",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18),
                                            ),
                                          )
                                        ]).show();
                                  }
                                });
                                                            },
                                                            child: const Text("TRUE"),
                                                            style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green.shade400,
                                 ),
                                                          ),
                              )),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                        width: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 60,
                              child: ElevatedButton(
                                
                                onPressed: () {
                                  setState(() {
                                    checkAnswer(false);
                                                      
                                    if (quizBrain.isQuestionEnd()) {
                                      int score = quizBrain.getScore();
                                      int totalQuestion = questionBank.length;
                                      Alert(
                                          context: context,
                                          type: AlertType.info,
                                          title: "Quiz Over",
                                          desc: "Score $score/$totalQuestion",
                                          buttons: [
                                            DialogButton(
                                              onPressed: () {
                                                setState(() {
                                                  quizBrain.restart();
                                                  Navigator.pop(context);
                                                });
                                              },
                                              color: const Color.fromRGBO(
                                                  0, 179, 134, 1.0),
                                              child: const Text(
                                                "Restart",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18),
                                              ),
                                            )
                                          ]).show();
                                    }
                                  });
                                },
                                child: const Text("FALSE"),
                                                      
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red.shade400,
                                           
                                          ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // ------------------Making bottom ScoreView--------------

                SingleChildScrollView(
                  reverse: true,
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: scoreKeeper,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
