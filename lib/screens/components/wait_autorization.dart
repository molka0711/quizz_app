//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Autorization extends StatefulWidget {
  const Autorization({super.key});

  @override
  State<Autorization> createState() => _AutorizationState();
}

class _AutorizationState extends State<Autorization> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Image.asset('assets/icons/wit.gif'),
    );
  }
}
