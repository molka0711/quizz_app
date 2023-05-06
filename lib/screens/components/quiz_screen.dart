import 'package:flutter/material.dart';
import 'package:quiz_app/constants.dart';

import '../../services/database.dart';


class QuizScreen extends StatefulWidget {
  final String quizId;

  QuizScreen({required this.quizId});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  // List<dynamic>? questions =displayQuizQuestions(widget.quizId);
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

  //List<dynamic> quizha = DatabaseService().getQuizData();
  @override
  void initState() {
    // display();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        backgroundColor: Colors.red,
        elevation: 0,
        title: Text("Quiz"),
      ),
      body: FutureBuilder(
          future: DatabaseService().displayQuizQuestions(widget.quizId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData) {
              questions = snapshot.data as List<dynamic>;
              print(questions);
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: kDefaultPadding),
                      Text(
                        questions![0]['question'],
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: kDefaultPadding),
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: questions!.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Text(
                                questions![index]['question'],
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                questions![index]['option1'],
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                questions![index]['option2'],
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                questions![index]['option3'],
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                questions![index]['correctAnswer'],
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      SizedBox(height: kDefaultPadding),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            "Submit",
                            style: TextStyle(fontSize: 20),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black,
                            padding: EdgeInsets.symmetric(
                              horizontal: kDefaultPadding * 2,
                              vertical: kDefaultPadding,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: kDefaultPadding),
                    ],
                  ),
                ),
              );
            }

            return Container();
          }),
    );
  }
}
