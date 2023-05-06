import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

class QuestionController extends GetxController
    with SingleGetTickerProviderMixin {
  //for progressBar animation
  late AnimationController _animationController;
  late Animation _animation;
  //to access animation
  Animation get animation => this._animation;
  //called immediately when the wigdet allocates memory
  @override
  void onInit() {
    //filling the progress bar whithin 60s
    _animationController =
        AnimationController(duration: Duration(seconds: 10), vsync: this);
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController)
      ..addListener(() {
        //update like setState
        update();
      });
    //to start animation
    _animationController.forward();
    super.onInit();
  }
}
