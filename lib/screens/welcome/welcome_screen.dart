import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:quiz_app/constants.dart';
import 'package:quiz_app/screens/auth/login.dart';
import 'package:quiz_app/screens/auth/main_page.dart';
import '../components/MyQuiz.dart';
import '../components/quiz_screen.dart';
import '../quiz/test.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final _formKey = GlobalKey<FormState>();
  String username = '';
  int score = 0;

  final codeController = TextEditingController();

  final nameController = TextEditingController();

  void addUser() async {
    final questionsRef = FirebaseFirestore.instance.collection('users');

    questionsRef.add({
      'username': username,
      'score': score,
    }).then((value) {
      print('User added');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('User  added'),
        ),
      );
    }).catchError((error) => print('Failed to add user: $error'));
  }

  void updatescore() {
    score++;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Stack widget pour superposer plusieurs widgets les uns sur les autres.
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/icons/back2.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ), // fit  pour spécifier comment l'image doit s'adapter à la taille disponible BoxFit.cover est utilisée pour étirer l'image afin qu'elle remplisse complètement l'espace disponible sans déformer l'image.
          SafeArea(
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Spacer(flex: 2),
                    SizedBox(
                      height: 25,
                    ),
                    Text(
                      "Let's play Quiz,",
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontWeight: FontWeight.bold),
                    ),
                    //Text("Enter your code to join Quiz"),
                    Spacer(),
                    TextField(
                      controller: nameController,
                      onChanged: (val) {
                        username = val;
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color.fromARGB(255, 34, 70, 109),
                        hintText: "Enter your FullName",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                      ),
                    ),
                    SizedBox(height: 25),
                    TextField(
                      controller: codeController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color.fromARGB(255, 34, 70, 109),
                        hintText: "Enter your code",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),

                    GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/login');
                        },
                        child: Center(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              'Create Quiz ?',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                        )),
                    Spacer(),
                    InkWell(
                      // onTap: () => Get.to(QuizScreen()),

                      onTap: () {
                        String quizId = codeController.text;
                        addUser();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ArtsPage(quizId: quizId),

                            //builder: (context) => MyGifImage(),
                            // builder: (context) => QuizScreen(quizId: quizId),
                          ),
                        );
                      },
                      child: Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(kDefaultPadding * 0.75),
                          decoration: BoxDecoration(
                              gradient: kPrimaryGradient,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12))),
                          child: Text(
                            "Let's start Quiz",
                            style: Theme.of(context)
                                .textTheme
                                .button
                                ?.copyWith(color: Colors.black),
                          )),
                    ),
                    Spacer(flex: 2), // it will takes 2/6 spaces
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
