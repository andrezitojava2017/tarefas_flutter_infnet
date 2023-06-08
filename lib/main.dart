import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/controller/tarefaProvider.dart';
import 'package:task_app/telas/home.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TarefaProvider()),
      ],
      child: MyApp(),
    ),
  );
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
