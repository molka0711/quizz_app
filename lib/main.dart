import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:quiz_app/screens/auth/login.dart';
import 'package:quiz_app/screens/auth/main_page.dart';
import 'package:quiz_app/screens/auth/register.dart';
import 'package:quiz_app/screens/quiz/test.dart';
import 'package:quiz_app/screens/welcome/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyA5P8BpC0jmyPZRp7W0-b5eQ3PowngAl0Q",
          appId: "1:870344887617:android:fa849172a8257a494925c0",
          messagingSenderId:
              "870344887617-ijevme8eftkb8vekobr994u6foqadk3g.apps.googleusercontent.com",
          projectId: "flutter-cfc23"));
  //testRead();
  //await displayQuizQuestions('670002bJ78453x57');

  runApp(MyApp());
}

/*void testRead() {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  users.doc("QI8dEJbqNqbXFXMz7yTM").get().then((value) {
    var a = value.data() as Map<String, dynamic>;
    print(a["name"]);
  });
}*/

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Quiz App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        routes: {
          '/': (context) => WelcomeScreen(),
          '/mainPage': (context) => MainPage(),
          '/login': (context) => LoginPage(),
          '/register': (context) => RegisterPage(),
        }
        //home: WelcomeScreen(),
        );
  }
}
