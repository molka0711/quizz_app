// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:quiz_app/screens/components/QuizOption.dart';

// import '../../constants.dart';
// import '../../services/database.dart';
// import '../quiz/quiz_screen.dart';

// class _QuizScreenState extends State<QuizScreen> {
//   List<dynamic>? questions; // liste de questions à afficher
//   int currentQuestion = 0; // index de la question en cours d'affichage
//   int correctAnswers =
//       0; // nombre de réponses correctes données par l'utilisateur

//   @override
//   void initState() {
//     super.initState();
//     displayQuizQuestions(); // afficher les questions du quiz
//   }

//   // fonction pour récupérer les questions du quiz depuis Firebase
//   Future<void> displayQuizQuestions() async {
//     List<dynamic>? quizQuestions =
//         await DatabaseService().displayQuizQuestions(widget.quizId);
//     if (quizQuestions != null) {
//       setState(() {
//         questions = quizQuestions;
//       });
//     }
//   }

//   // fonction pour gérer la réponse de l'utilisateur à une question
//   void handleAnswer(int selectedIndex) {
//     if (selectedIndex == questions![currentQuestion]['correctAnswer']) {
//       // si la réponse est correcte, incrémenter le nombre de réponses correctes
//       setState(() {
//         correctAnswers++;
//       });
//     }
//     if (currentQuestion < questions!.length - 1) {
//       // si ce n'est pas la dernière question, passer à la question suivante
//       setState(() {
//         currentQuestion++;
//       });
//     } /*else {
//       // si c'est la dernière question, afficher le score final
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (_) => QuizScoreScreen(
//             score: correctAnswers,
//             totalQuestions: questions!.length,
//           ),
//         ),
//       );
//     }*/
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: kSecondaryColor,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(
//             Icons.arrow_back_ios_new,
//             color: kSecondaryColor,
//           ),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: Text(
//           "Quiz",
//           style: TextStyle(
//             color: kSecondaryColor,
//             fontSize: 28,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(height: 20),
//               Text(
//                 "${currentQuestion + 1}/${questions?.length ?? 0}",
//                 style: TextStyle(color: kGrayColor, fontSize: 16),
//               ),
//               SizedBox(height: 10),
//               Text(
//                 questions != null
//                     ? questions![currentQuestion]['question']
//                     : "",
//                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 20),
//               ...(questions != null
//                   ? List.generate(
//                       questions![currentQuestion]['options'].length,
//                       (i) => QuizOption(
//                         index: i,
//                         text: questions![currentQuestion]['options'][i],
//                         press: () => handleAnswer(i),
//                       ),
//                     )
//                   : [Container()]),
//               Spacer(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
