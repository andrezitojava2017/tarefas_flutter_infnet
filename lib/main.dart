import 'package:flutter/material.dart';
import 'package:task_app/telas/home.dart';
import 'package:task_app/telas/novaTarefa.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}
