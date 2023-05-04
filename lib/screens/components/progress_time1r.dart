import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/constants.dart';

class ProgressTimer extends StatelessWidget {
  final count = 5.obs; // mettre l'observable ici

  ProgressTimer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
        height: 50,
        width: 50,
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: [
            CircularProgressIndicator(
              value: 1 - (100 / 15),
              color: kSecondaryColor,
              backgroundColor: Colors.grey,
              strokeWidth: 8,
            ),
            Center(
              child: Text(
                '${count.value}', // accéder à la valeur de l'observable
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: kSecondaryColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
