import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  DatabaseService();

  getQuizData() async {
    return await firestore.collection("quizzes").snapshots();
  }

  getQuestionData(String quizId) async {
    return await firestore
        .collection("quizzes")
        .doc(quizId)
        .collection("questions")
        .get();
  }

  Future<List<dynamic>?> displayQuizQuestions(String quizId) async {
    CollectionReference<Map<String, dynamic>> quizCollection =
        FirebaseFirestore.instance.collection('quizzes');
    QuerySnapshot<Map<String, dynamic>> quizSnapshot =
        await quizCollection.where('quizId', isEqualTo: quizId).get();

    if (quizSnapshot.docs.isNotEmpty) {
      QueryDocumentSnapshot<Map<String, dynamic>> quizDoc =
          quizSnapshot.docs.first;
      CollectionReference<Map<String, dynamic>> questionsCollection =
          quizCollection.doc(quizDoc.data()["quizId"]).collection('questions');

      QuerySnapshot<Map<String, dynamic>> questionsSnapshot =
          await questionsCollection.get();
      print(questionsSnapshot.docs.length);
      if (questionsSnapshot.docs.isNotEmpty) {
        List<QueryDocumentSnapshot<Map<String, dynamic>>> questionDocs =
            questionsSnapshot.docs;
        List<dynamic> res = List.empty(growable: true);
        for (QueryDocumentSnapshot<Map<String, dynamic>> questionDoc
            in questionDocs) {
          String question = questionDoc.data()['question'];
          String correctAnswer = questionDoc.data()['correctAnswer'];
          List<String> options = [
            questionDoc.data()['option1'],
            questionDoc.data()['option2'],
            questionDoc.data()['option3']
          ];
          res.add(questionDoc.data());
          print('Question: $question');
          print('Correct Answer: $correctAnswer');
          print('Options: ${options.join(", ")}');
          print('-------------------');
        }
        print(res);

        return res;
      } else {
        print('No questions found for quiz with ID $quizId');
      }
    } else {
      print('Quiz with ID $quizId not found');
    }
  }
}
