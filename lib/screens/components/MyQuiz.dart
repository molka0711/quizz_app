import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
  var score = 0;
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
    FirebaseFirestore.instance
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

  reset() {
    setState(() {
      index = 0;
      score = 0;
    });
  }

// Dans la méthode handleAnswer(), ajoutez le code suivant:

  @override
  void initState() {
    // display();
    super.initState();
  }

  void calculateScore(scoreF) {
    scoreF = (100 / nbquestion) * score;
  }

  void test() {
    if (nbquestion == questions!.length) {
      finish = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text(
          'Quiz',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Expanded(
                      flex: 4,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          border: Border.all(
                              color: Color.fromARGB(255, 54, 33, 243)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
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
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                index++;
                                nbquestion++;
                                setState(() {});
                              },
                              child: Ink(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.blue,
                                      Colors.indigo.shade500,
                                      Colors.blue,
                                    ],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                  borderRadius: BorderRadius.circular(20.0),
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
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                index++;
                                nbquestion++;
                                setState(() {});
                              },
                              child: Ink(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.blue,
                                      Colors.indigo.shade500,
                                      Colors.blue,
                                    ],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                  borderRadius: BorderRadius.circular(20.0),
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
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                index++;
                                nbquestion++;
                                setState(() {});
                              },
                              child: Ink(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.blue,
                                      Colors.indigo.shade500,
                                      Colors.blue,
                                    ],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                  borderRadius: BorderRadius.circular(20.0),
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
                          SizedBox(width: 16.0),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                index++;
                                nbquestion++;
                                score++;
                                setState(() {});
                              },
                              child: Ink(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.deepPurple,
                                      Colors.indigo.shade500,
                                      Colors.deepPurple,
                                    ],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                  borderRadius: BorderRadius.circular(20.0),
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
                        ],
                      ),
                    ),
                    SizedBox(height: 25.0),
                  ],
                ),
              );
            }
            return SizedBox();
          }),
    );
  }
}
