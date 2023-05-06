import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class CreateQuestions extends StatefulWidget {
  final String quizId;
  CreateQuestions({required this.quizId});

  @override
  _CreateQuestionsState createState() => _CreateQuestionsState();
}

class _CreateQuestionsState extends State<CreateQuestions> {
  final _formKey = GlobalKey<FormState>();
  String question = '';
  String option1 = '';
  String option2 = '';
  String option3 = '';
  String correctAnswer = '';
  int questionNumber = 0;

  @override
  void initState() {
    super.initState();
    _fetchQuestionCount();
  }

  void _fetchQuestionCount() async {
    final questionsRef = FirebaseFirestore.instance
        .collection('quizzes')
        .doc(widget.quizId)
        .collection('questions');
    final querySnapshot = await questionsRef.get();
    final totalQuestions = querySnapshot.size;
    setState(() {
      questionNumber = totalQuestions + 1; // add 1 here
    });
  }

  void addQuestion() async {
    if (_formKey.currentState!.validate()) {
      final questionsRef = FirebaseFirestore.instance
          .collection('quizzes')
          .doc(widget.quizId)
          .collection('questions');

      final querySnapshot = await questionsRef.get();
      final totalQuestions = querySnapshot.size;
      final currentQuestionNumber = totalQuestions + 1;

      questionsRef.add({
        'question': question,
        'option1': option1,
        'option2': option2,
        'option3': option3,
        'correctAnswer': correctAnswer,
      }).then((value) {
        print('Question added');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Question n°$currentQuestionNumber added'),
          ),
        );
      }).catchError((error) => print('Failed to add question: $error'));

      setState(() {
        _formKey.currentState!.reset();
        question = '';
        option1 = '';
        option2 = '';
        option3 = '';
        correctAnswer = '';
        questionNumber = currentQuestionNumber;
      });
    }
  }

  void finishQuiz() async {
    addQuestion();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Home()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Create a new Quiz',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        elevation: 0.0,
        backgroundColor: Color.fromARGB(255, 111, 198, 211),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Center(child: Image.asset('assets/icons/question.gif')),
              SizedBox(
                height: 20,
              ),
              Text("Question n°$questionNumber"),
              SizedBox(
                height: 20,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      validator: (val) =>
                          val!.isEmpty ? "Enter the question" : null,
                      decoration: InputDecoration(
                        hintText: "Question",
                        hintStyle: TextStyle(color: Colors.grey[400]),
                      ),
                      style: TextStyle(color: Colors.black),
                      onChanged: (val) {
                        question = val;
                      },
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    TextFormField(
                      validator: (val) =>
                          val!.isEmpty ? "Enter option 1" : null,
                      decoration: InputDecoration(
                        hintText: "Option 1",
                        hintStyle: TextStyle(color: Colors.grey[400]),
                      ),
                      style: TextStyle(color: Colors.black),
                      onChanged: (val) {
                        option1 = val;
                      },
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    TextFormField(
                      validator: (val) =>
                          val!.isEmpty ? "Enter option 2" : null,
                      decoration: InputDecoration(
                        hintText: "Option 2",
                        hintStyle: TextStyle(color: Colors.grey[400]),
                      ),
                      style: TextStyle(color: Colors.black),
                      onChanged: (val) {
                        option2 = val;
                      },
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    TextFormField(
                      validator: (val) =>
                          val!.isEmpty ? "Enter option 3" : null,
                      decoration: InputDecoration(
                        hintText: "Option 3",
                        hintStyle: TextStyle(color: Colors.grey[400]),
                      ),
                      style: TextStyle(color: Colors.black),
                      onChanged: (val) {
                        option3 = val;
                      },
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    TextFormField(
                      validator: (val) =>
                          val!.isEmpty ? "Enter the correct answer" : null,
                      decoration: InputDecoration(
                        hintText: "Correct Answer",
                        hintStyle: TextStyle(color: Colors.grey[400]),
                      ),
                      style: TextStyle(color: Colors.black),
                      onChanged: (val) {
                        correctAnswer = val;
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: finishQuiz,
                    child: Text('Finish Quiz'),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Color.fromARGB(255, 111, 198, 211),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: addQuestion,
                    child: Text('Next Question'),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Color.fromARGB(255, 111, 198, 211),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
