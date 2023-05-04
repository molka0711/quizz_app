import 'package:flutter/material.dart';
import 'package:flutter_gifimage/flutter_gifimage.dart';

class MyGifImage extends StatefulWidget {
  const MyGifImage({Key? key}) : super(key: key);

  @override
  State<MyGifImage> createState() => _MyGifImageState();
}

class _MyGifImageState extends State<MyGifImage> with TickerProviderStateMixin {
  late final GifController _controller;

  @override
  void initState() {
    super.initState();
    _controller = GifController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GifImage(
      controller: _controller,
      image: AssetImage('assets/wit.gif'),
    );
  }
}
