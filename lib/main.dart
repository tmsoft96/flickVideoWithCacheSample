import 'package:flutter/material.dart';
import 'package:try_work/feedPlayer.dart';
import 'package:try_work/samplePlayer.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FeedPlayer(),
    );
  }
}
