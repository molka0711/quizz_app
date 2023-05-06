import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/screens/components/finish.dart';
import 'package:quiz_app/screens/components/progress_bar.dart';
import '../../constants.dart';
import '../../services/database.dart';
import 'classes.dart';

class ArtsPage extends StatefulWidget {
  final String quizId;

  const ArtsPage({super.key, required this.quizId});

  @override
  _ArtsPageState createState() => _ArtsPageState();
}

class _ArtsPageState extends State<ArtsPage> {
  var index = 0;
  int scoreF = 0;
  int score = 0;
  int nbquestion = 1;
  bool finish = false;

  List<dynamic>? questions = List.empty();
  Future<void> display() async {
    var quizQuestions =
        await DatabaseService().displayQuizQuestions(widget.quizId).then(
              (value) => value,
            );

    print(quizQuestions);
    if (quizQuestions != null) {
      questions = quizQuestions;

      print("aaaa");
      print(questions);
      setState(() {});
    }
  }

  void updateScore() {
    final firebase = FirebaseFirestore.instance
        .collection('users')
        .doc('score')
        .update({'score': scoreF})
        .then((value) => print('Score updated'))
        .catchError((error) => print('Failed to update score: $error'));
  }

  // checkWin(bool userChoice, BuildContext context) {
  //   if (userChoice == qList[counter].isCorrect) {
  //     print("correct");

  //     score = score + 5;
  //     final snackbar = SnackBar(
  //       duration: Duration(milliseconds: 500),
  //       backgroundColor: Colors.green,
  //       content: Text("Correct!"),
  //     );
  //     ScaffoldMessenger.of(context).showSnackBar(snackbar);
  //   } else {
  //     print("false");
  //     score = score + 0;
  //     final snackbar = SnackBar(
  //       duration: Duration(milliseconds: 500),
  //       backgroundColor: Colors.red,
  //       content: Text("Incorrect!"),
  //     );
  //     ScaffoldMessenger.of(context).showSnackBar(snackbar);
  //   }
  //   setState(() {
  //     if (counter < 4) {
  //       counter = counter + 1;
  //     }
  //   });
  // }

  // reset() {
  //   setState(() {
  //     index = 0;
  //     score = 0;
  //   });
  // }

// Dans la méthode handleAnswer(), ajoutez le code suivant:

  @override
  void initState() {
    // display();
    super.initState();
  }

  void calculateScore(scoreF) {
    scoreF = (100 / nbquestion) * score;
  }

  bool test(List<dynamic>? quest) {
    if (nbquestion > quest!.length) {
      finish = true;
    } else
      finish = false;
    return finish;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Quiz',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        elevation: 0.0,
        backgroundColor: Color.fromARGB(255, 111, 198, 211),
      ),
      backgroundColor: Colors.white,
      body: FutureBuilder(
          future: DatabaseService().displayQuizQuestions(widget.quizId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData) {
              questions = snapshot.data as List<dynamic>;
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
                child: !test(questions)
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          ProgressBar(),
                          SizedBox(
                            height: 20,
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0),
                                border: Border.all(
                                  color: Color.fromARGB(255, 6, 135, 204),
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Question ${index + 1}/ ${questions!.length}",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                    ),
                                  ),
                                  Text(
                                    questions![index]['question'],
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    // qList[counter].qText,
                                    // textAlign: TextAlign.center,
                                    // style: TextStyle(
                                    //   fontWeight: FontWeight.bold,
                                    //   fontSize: 24,
                                    // ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 24.0),
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          backgroundColor: Colors.red,
                                          content: Text('Ouups! Wrong answer'),
                                        ),
                                      );

                                      nbquestion++;
                                      Timer(Duration(seconds: 10), () {
                                        setState(() {});
                                        index++;
                                      });
                                      //setState(() {});

                                      print("index ${index}");
                                      print("nbquestion ${index}");
                                      print(questions!.length);
                                    },
                                    child: Ink(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      child: Container(
                                        constraints: BoxConstraints(
                                            maxWidth: 300.0, minHeight: 50.0),
                                        alignment: Alignment.center,
                                        child: Text(
                                          questions![index]['option1'],
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          backgroundColor: Colors.red,
                                          content: Text('Ouups! Wrong answer'),
                                        ),
                                      );
                                      nbquestion++;
                                      Timer(Duration(seconds: 10), () {
                                        setState(() {});
                                        index++;
                                      });

                                      //setState(() {});
                                    },
                                    child: Ink(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      child: Container(
                                        constraints: BoxConstraints(
                                            maxWidth: 300.0, minHeight: 50.0),
                                        alignment: Alignment.center,
                                        child: Text(
                                          questions![index]['option2'],
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          backgroundColor: Colors.red,
                                          content: Text('Ouups! Wrong answer'),
                                        ),
                                      );
                                      nbquestion++;
                                      Timer(Duration(seconds: 10), () {
                                        setState(() {});
                                        index++;
                                      });
                                    },
                                    child: Ink(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      child: Container(
                                        constraints: BoxConstraints(
                                            maxWidth: 300.0, minHeight: 50.0),
                                        alignment: Alignment.center,
                                        child: Text(
                                          questions![index]['option3'],
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          backgroundColor: Colors.green,
                                          content: Text('Correct Answer'),
                                        ),
                                      );
                                      nbquestion++;
                                      Timer(Duration(seconds: 10), () {
                                        setState(() {});
                                        index++;
                                        score++;

                                        print(score);
                                      });
                                    },
                                    child: Ink(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      child: Container(
                                        constraints: BoxConstraints(
                                            maxWidth: 300.0, minHeight: 50.0),
                                        alignment: Alignment.center,
                                        child: Text(
                                          questions![index]['correctAnswer'],
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.0),
                                      border: Border.all(
                                          color:
                                              Color.fromARGB(255, 54, 33, 243)),
                                    ),
                                    child: Center(
                                      child: FittedBox(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Your Score is $score ",
                                              style: TextStyle(
                                                color: Colors.deepPurple,
                                                fontSize: 24.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        //
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 25.0),
                        ],
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 10), //here
                          Text(
                            "Congratulations! You have completed the quiz. Now it's time to see how you did.\n\n        Your Score is  $score/$questions ",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          Center(child: Image.asset('assets/icons/result.gif')),
                          SizedBox(height: 150),
                          SizedBox(height: 10),
                          Expanded(
                            child: SizedBox(
                              width: 220,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () {
                                  updateScore();
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ResultsScreen()),
                                  );
                                },
                                child: Ink(
                                  decoration: BoxDecoration(
                                    gradient: kPrimaryGradient,
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Container(
                                    constraints: BoxConstraints(
                                        maxWidth: 150.0, minHeight: 40.0),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Show results",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 250)
                        ],
                      ),
              );
            }
            return SizedBox();
          }),
    );
  }
}
