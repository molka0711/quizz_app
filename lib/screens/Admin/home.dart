import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiz_app/screens/Admin/start_quiz.dart';
import 'package:quiz_app/services/database.dart';
import 'package:quiz_app/screens/Admin/create_quiz.dart';
import 'package:quiz_app/screens/components/widget.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Stream quizStream = Stream.empty();
  DatabaseService databaseService = new DatabaseService();

  Widget quizList() {
    return Container(
      child: Column(
        children: [
          StreamBuilder(
            stream: quizStream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              }

              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return Center(child: Text('No data'));
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator());
                default:
                  QuerySnapshot<Map<String, dynamic>>? querySnapshot =
                      snapshot.data as QuerySnapshot<Map<String, dynamic>>?;
                  List<QueryDocumentSnapshot<Map<String, dynamic>>> docsList =
                      querySnapshot?.docs ?? [];

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: docsList.length,
                    itemBuilder: (context, index) {
                      QueryDocumentSnapshot<Map<String, dynamic>> doc =
                          docsList[index];
                      String id = doc.id;

                      String title = doc.get('title') ?? '';
                      String description =
                          'Quiz ID: ' + (doc.get('quizId') ?? '');
                      String imageUrl = doc.get('imageUrl') ?? '';

                      return GestureDetector(
                        onTap: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => QuizStart(),
                            ),
                          );
                          if (result != null) {
                            setState(() {
                              id = result;
                            });
                          }
                        },
                        child: QuizTile(
                          title: title,
                          imageUrl: imageUrl,
                          description: description,
                          id: id,
                          noOfQuestions: 3,
                        ),
                      );
                    },
                  );
              }
            },
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    databaseService.getQuizData().then((value) {
      quizStream = value;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: AppLogo(),
        brightness: Brightness.light,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: quizList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CreateQuiz()));
        },
      ),
    );
  }
}

class QuizTile extends StatelessWidget {
  final String imageUrl, title, id, description;
  final int noOfQuestions;

  QuizTile({
    required this.title,
    required this.imageUrl,
    required this.description,
    required this.id,
    required this.noOfQuestions,
  });

  @override
  Widget build(BuildContext context) {
    void _copyToClipboard() {
      Clipboard.setData(ClipboardData(text: description));
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Copied to clipboard'),
        duration: Duration(seconds: 1),
      ));
    }

    return GestureDetector(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        height: 150,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Stack(
            children: [
              Image.network(
                imageUrl,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
              ),
              Container(
                color: Colors.black26,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        description,
                        style: TextStyle(
                            fontSize: 13,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 20),
                      IconButton(
                        icon: Icon(Icons.copy),
                        onPressed: _copyToClipboard,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
