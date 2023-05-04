import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

import '../quiz/test.dart';
import 'home.dart';

class QuizStart extends StatefulWidget {
  @override
  _QuizStartState createState() => _QuizStartState();
}

class _QuizStartState extends State<QuizStart> {
  bool _isStarted = false;

  Future<bool?> pause() async {
    await Future.delayed(const Duration(milliseconds: 500), () {
      return true;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Duration myduration = Duration(minutes: 2);
    _startQuiz() {}

    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Afficher le bouton de démarrage du quiz
            !_isStarted
                ? ElevatedButton(
                    onPressed: () {
                      _isStarted = true;
                      setState(() {});
                    },
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue,
                      ),
                      child: Center(
                        child: Text(
                          'Start',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  )
                // Afficher le bouton pour accéder au quiz
                : ElevatedButton(
                    onPressed: () {
                      // displayQuizQuestions('3eBV1VCWW2c06FXU');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SizedBox(),
                        ),
                      );
                    },
                    child: Text('Show Quiz'),
                  ),
            SizedBox(height: 20),
            // Afficher un compteur de 2 minutes
            /*        _isStarted
                ? FutureBuilder(
                    future: pause(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState ==
                          ConnectionState.waiting) {}
                      if (!snapshot.hasData) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasData) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Home()));
                      }
                      return Container();
                    })
                : SizedBox(), */
          ],
        ),
      ),
    );
  }
}
