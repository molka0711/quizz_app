import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/screens/components/widget.dart';
import 'package:quiz_app/screens/Admin/create_question.dart';
import 'package:random_string/random_string.dart';

import '../../constants.dart';
import 'create_question.dart';

class CreateQuiz extends StatefulWidget {
  const CreateQuiz({super.key});

  @override
  State<CreateQuiz> createState() => _CreateQuizState();
}

class _CreateQuizState extends State<CreateQuiz> {
  final _formKey = GlobalKey<FormState>();

  String quizImageUrl = '';
  String quizTitle = '';
  String quizDescription = '';
  String quizId = '';

  void createQuiz(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      quizId = randomAlphaNumeric(16);
      FirebaseFirestore.instance
          .collection('quizzes')
          .add({
            ''
                'imageUrl': quizImageUrl,
            'title': quizTitle,
            'description': quizDescription,
            'quizId': quizId,
          })
          .then((value) => {
                print('Quiz added'),
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CreateQuestions(
                              quizId: quizId,
                            ))),
              })
          .catchError((error) => print('Failed to add quiz: $error'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create a new Quiz',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        elevation: 0.0,
        backgroundColor: Color.fromARGB(255, 111, 198, 211),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                Center(child: Image.asset('assets/icons/quiz1.gif')),
                Spacer(flex: 2),
                TextFormField(
                  validator: (val) => val!.isEmpty ? "Enter Image URL" : null,
                  decoration: InputDecoration(
                      hintText: "Quiz Image URL",
                      hintStyle: TextStyle(color: Colors.grey)),
                  onChanged: (val) {
                    quizImageUrl = val;
                  },
                  style: TextStyle(color: kBlackColor),
                ),
                SizedBox(
                  height: 6,
                ),
                TextFormField(
                  validator: (val) => val!.isEmpty ? "Enter Quiz Title" : null,
                  decoration: InputDecoration(
                      hintText: "Quiz Title",
                      hintStyle: TextStyle(color: Colors.grey)),
                  onChanged: (val) {
                    quizTitle = val;
                  },
                  style: TextStyle(color: kBlackColor),
                ),
                SizedBox(
                  height: 6,
                ),
                TextFormField(
                  validator: (val) =>
                      val!.isEmpty ? "Enter Quiz Description" : null,
                  decoration: InputDecoration(
                      hintText: "Quiz Description",
                      hintStyle: TextStyle(color: Colors.grey)),
                  style: TextStyle(color: kBlackColor),
                  onChanged: (val) {
                    quizDescription = val;
                  },
                ),
                Spacer(),
                Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: kPrimaryGradient,
                    ),
                    child: GestureDetector(
                      onTap: () => createQuiz(context), // pass the context
                      child: Center(
                        child: Text(
                          'Create a new Quiz',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    )),
                SizedBox(
                  height: 80,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
