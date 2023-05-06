import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ResultsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Results"),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Center(child: Image.asset('assets/icons/result.gif')),
            Text(
              "Quiz Results",
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            // Expanded(
            //   child: FutureBuilder<QuerySnapshot>(
            //     future: FirebaseFirestore.instance
            //         .collection('users')
            //         .orderBy('score', descending: true)
            //         .get(),
            //     builder: (BuildContext context,
            //         AsyncSnapshot<QuerySnapshot> snapshot) {
            //       if (!snapshot.hasData) {
            //         return Center(child: CircularProgressIndicator());
            //       }

            //       final users = snapshot.data!.docs;

            //       return DataTable(
            //         columns: [
            //           DataColumn(label: Text('Rank')),
            //           DataColumn(label: Text('Username')),
            //           DataColumn(label: Text('Score')),
            //         ],
            //         rows: List<DataRow>.generate(
            //           users.length,
            //           (index) {
            //             final user = users[index].data();
            //             return DataRow(
            //               cells: <DataCell>[
            //                 // DataCell(Text((index + 1).toString())),
            //                 // DataCell(Text(user['username'] ?? "")),
            //                 // DataCell(Text(user??toString() ?? "")),
            //                 // DataCell(Text(user['score'].toString())),
            //               ],
            //             );
            //           },
            //         ),
            //       );
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
