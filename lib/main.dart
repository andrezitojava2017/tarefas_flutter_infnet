/*
CONFIGURAÇÃO FIREBASE FLUTTER
-	firebase login / firebase logout
-	dart pub global activate flutterfire_cli
-	firebase projects:create tarefas-flutter-infnet --json
-	flutterfire configure  (escolher projeto)
-	flutter pub add firebase_core
*/

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:task_app/controller/tarefa_provider.dart';
import 'package:task_app/firebase_options.dart';
import 'package:task_app/telas/home.dart';

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    MockFirebaseFirestore? mockFirestore;
    mockFirestore = MockFirebaseFirestore();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => TarefaProvider(firestore: mockFirestore!)),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Home(),
      ),
    );
  }
}
