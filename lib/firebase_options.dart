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
    apiKey: 'AIzaSyBkf6AxHIXH-3LyT2p7zFWy81S9c-9Vgcw',
    appId: '1:804579935016:web:7c00f950e38d998901461d',
    messagingSenderId: '804579935016',
    projectId: 'tadreby-c2ce0',
    authDomain: 'tadreby-c2ce0.firebaseapp.com',
    databaseURL: 'https://tadreby-c2ce0-default-rtdb.firebaseio.com',
    storageBucket: 'tadreby-c2ce0.appspot.com',
    measurementId: 'G-V0QB9N3J8W',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB_KolU23b7Ydqt4tYo2KuImfVlFAKSoMc',
    appId: '1:804579935016:android:6fc3d588973cd04d01461d',
    messagingSenderId: '804579935016',
    projectId: 'tadreby-c2ce0',
    databaseURL: 'https://tadreby-c2ce0-default-rtdb.firebaseio.com',
    storageBucket: 'tadreby-c2ce0.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAqNrW6NTH7J2aQUtOApMg_QnN8JPPTN4w',
    appId: '1:804579935016:ios:1190a88a093f57c101461d',
    messagingSenderId: '804579935016',
    projectId: 'tadreby-c2ce0',
    databaseURL: 'https://tadreby-c2ce0-default-rtdb.firebaseio.com',
    storageBucket: 'tadreby-c2ce0.appspot.com',
    iosBundleId: 'com.example.inter',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAqNrW6NTH7J2aQUtOApMg_QnN8JPPTN4w',
    appId: '1:804579935016:ios:bf6aea4bda7ad77a01461d',
    messagingSenderId: '804579935016',
    projectId: 'tadreby-c2ce0',
    databaseURL: 'https://tadreby-c2ce0-default-rtdb.firebaseio.com',
    storageBucket: 'tadreby-c2ce0.appspot.com',
    iosBundleId: 'com.example.inter.RunnerTests',
  );
}
