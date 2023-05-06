import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quiz_app/constants.dart';
import 'package:quiz_app/controllers/questions_controller.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:quiz_app/screens/components/MyQuiz.dart';

class ProgressBar extends StatelessWidget {
  //constructeur
  const ProgressBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 35,
        decoration: BoxDecoration(
          border: Border.all(
              color: Color(0xFF3F4768), width: 3), //bordure d'épaisseur 3
          borderRadius: BorderRadius.circular(50),
        ),
        child: GetBuilder<QuestionController>(
            // Initialize the controller and rebuild the widget when the controller updates
            init: QuestionController(),
            builder: (controller) {
              //print(controller.animation.value);
              return Stack(
                children: [
                  //Layout builder provide us the available space for the container
                  //constraints.maxwidth needed for our animation
                  LayoutBuilder(
                    builder: (context, constraints) => Container(
                      width: constraints.maxWidth * controller.animation.value,
                      decoration: BoxDecoration(
                          gradient: kPrimaryGradient,
                          borderRadius: BorderRadius.circular(50)),
                    ),
                  ),
                  Positioned.fill(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: kDefaultPadding / 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                "${(controller.animation.value * 60).round()} sec"),
                            SvgPicture.asset("assets/icons/clock.svg"),
                          ],
                        )),
                  )
                ],
              );
            }));
  }
}
// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:quiz_app/screens/components/finish.dart';

// class MyCircularProgressBar extends StatefulWidget {
//   const MyCircularProgressBar({Key? key}) : super(key: key);

//   @override
//   _MyCircularProgressBarState createState() => _MyCircularProgressBarState();
// }

// class _MyCircularProgressBarState extends State<MyCircularProgressBar> {
//   double _progressValue = 0;
//   Timer? _timer;

//   @override
//   void initState() {
//     super.initState();
//     // Start the timer to increment progress value
//     _timer = Timer.periodic(Duration(seconds: 1), (timer) {
//       setState(() {
//         _progressValue += 0.1;
//         // If progress is completed (i.e. 100%)
//         // skip to the next page
//         if (_progressValue >= 1) {
//           timer.cancel(); // Stop the timer
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => ResultScreen(),
//             ),
//           );
//           //Navigator.pushReplacementNamed(context, '/next_page');
//         }
//       });
//     });
//   }

//   @override
//   void dispose() {
//     _timer?.cancel(); // Cancel the timer when the widget is disposed
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: SizedBox(
//           width: 10,
//           height: 10,
//           child: CircularProgressIndicator(
//             value: _progressValue,
//             strokeWidth: 2,
//             backgroundColor: Colors.grey[300],
//             valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
//           ),
//         ),
//       ),
//     );
//   }
// }
