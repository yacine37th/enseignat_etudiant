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
    apiKey: 'AIzaSyAg065cGi-2Pcw1PkLBFHxzAyoEdJB57ys',
    appId: '1:680828629986:web:f85fc324a1786056c3ffbb',
    messagingSenderId: '680828629986',
    projectId: 'enseignant-c6cca',
    authDomain: 'enseignant-c6cca.firebaseapp.com',
    storageBucket: 'enseignant-c6cca.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBdeoYZB81JiqsnR14eDs9eiLwJumePJ-k',
    appId: '1:680828629986:android:3827fff336a69931c3ffbb',
    messagingSenderId: '680828629986',
    projectId: 'enseignant-c6cca',
    storageBucket: 'enseignant-c6cca.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDLmQIc-5DoEMOZczNhNdC3NH5IGg7VNKY',
    appId: '1:680828629986:ios:0caba33e5b0fd65ac3ffbb',
    messagingSenderId: '680828629986',
    projectId: 'enseignant-c6cca',
    storageBucket: 'enseignant-c6cca.appspot.com',
    iosClientId: '680828629986-4holfcpjulqqkemiedsf58psqnt4iata.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterApplication1',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDLmQIc-5DoEMOZczNhNdC3NH5IGg7VNKY',
    appId: '1:680828629986:ios:81f5d59a35e7363fc3ffbb',
    messagingSenderId: '680828629986',
    projectId: 'enseignant-c6cca',
    storageBucket: 'enseignant-c6cca.appspot.com',
    iosClientId: '680828629986-v747grq04g3qg0kpfkjt5lmi2ga2radt.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterApplication1.RunnerTests',
  );
}
