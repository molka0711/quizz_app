import 'package:cloud_firestore/cloud_firestore.dart';
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

  void permissionAdmin() async {
    // final questionsRef = FirebaseFirestore.instance.collection('admins');

    // questionsRef.add({
    //   '_isStarted': _isStarted,
    // }).then((value) {
    //   print('User authorized');
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       content: Text('User authorized'),
    //     ),
    //   );

    ///
    final CollectionReference myCollectionRef =
        FirebaseFirestore.instance.collection('quizzes');

    myCollectionRef.get().then((snapshot) {
      for (DocumentSnapshot doc in snapshot.docs) {
        myCollectionRef.doc(doc.id).update({
          '_isStarted': 'true',
        });
      }
    }).catchError((error) => print('Acess Denied: $error'));
  }

  @override
  Widget build(BuildContext context) {
    // Duration myduration = Duration(minutes: 2);
    _startQuiz() {}

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Start Quiz',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        elevation: 0.0,
        backgroundColor: Color.fromARGB(255, 111, 198, 211),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: Image.asset('assets/icons/start.gif')),
            SizedBox(
              height: 20,
            ),
            // Afficher le bouton de démarrage du quiz
            !_isStarted
                ? ElevatedButton(
                    onPressed: () {
                      _isStarted = true;
                      permissionAdmin();
                      setState(() {});
                    },
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(255, 111, 198, 211),
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
                : SizedBox(height: 20),
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
