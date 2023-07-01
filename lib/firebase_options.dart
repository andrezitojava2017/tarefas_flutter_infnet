// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCE7ja7f5Sr-XSxPdzvJWWXWln0SbnpAGg',
    appId: '1:25227862561:web:7c7566f4e3c86fef99f960',
    messagingSenderId: '25227862561',
    projectId: 'tarefas-flutter-infnet',
    authDomain: 'tarefas-flutter-infnet.firebaseapp.com',
    storageBucket: 'tarefas-flutter-infnet.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBZVz3bzEfCsF762UdvEpdi5-_LZgMs6mw',
    appId: '1:25227862561:android:1aa60a424c912f8499f960',
    messagingSenderId: '25227862561',
    projectId: 'tarefas-flutter-infnet',
    storageBucket: 'tarefas-flutter-infnet.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDDhpUP-9cqITK7Ly7A0xe3spWgPvzhogA',
    appId: '1:25227862561:ios:6be0b3d6edb594fe99f960',
    messagingSenderId: '25227862561',
    projectId: 'tarefas-flutter-infnet',
    storageBucket: 'tarefas-flutter-infnet.appspot.com',
    iosClientId: '25227862561-t87rbjqfl7jphukt7nvlo8p8jmdglef8.apps.googleusercontent.com',
    iosBundleId: 'com.example.taskApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDDhpUP-9cqITK7Ly7A0xe3spWgPvzhogA',
    appId: '1:25227862561:ios:6be0b3d6edb594fe99f960',
    messagingSenderId: '25227862561',
    projectId: 'tarefas-flutter-infnet',
    storageBucket: 'tarefas-flutter-infnet.appspot.com',
    iosClientId: '25227862561-t87rbjqfl7jphukt7nvlo8p8jmdglef8.apps.googleusercontent.com',
    iosBundleId: 'com.example.taskApp',
  );
}
