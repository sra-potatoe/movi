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
    apiKey: 'AIzaSyB9vkw6P3iSYQ_Td3NMfLenNNiK4eO0v1Q',
    appId: '1:963892597032:web:ee03ce3a49d030584d801d',
    messagingSenderId: '963892597032',
    projectId: 'movil-2-db4ad',
    authDomain: 'movil-2-db4ad.firebaseapp.com',
    databaseURL: 'https://movil-2-db4ad-default-rtdb.firebaseio.com',
    storageBucket: 'movil-2-db4ad.appspot.com',
    measurementId: 'G-MFC6BGEWTJ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyALEICMRGnD-jaUZkIWjw9rJKW09sxQwHQ',
    appId: '1:963892597032:android:948f2867587366484d801d',
    messagingSenderId: '963892597032',
    projectId: 'movil-2-db4ad',
    databaseURL: 'https://movil-2-db4ad-default-rtdb.firebaseio.com',
    storageBucket: 'movil-2-db4ad.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCccw55k1alu8_ubmGqr5jhMG2RR3Em3DY',
    appId: '1:963892597032:ios:862aac20e32c50a24d801d',
    messagingSenderId: '963892597032',
    projectId: 'movil-2-db4ad',
    databaseURL: 'https://movil-2-db4ad-default-rtdb.firebaseio.com',
    storageBucket: 'movil-2-db4ad.appspot.com',
    iosBundleId: 'com.example.flutterEx',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCccw55k1alu8_ubmGqr5jhMG2RR3Em3DY',
    appId: '1:963892597032:ios:95af52666973136f4d801d',
    messagingSenderId: '963892597032',
    projectId: 'movil-2-db4ad',
    databaseURL: 'https://movil-2-db4ad-default-rtdb.firebaseio.com',
    storageBucket: 'movil-2-db4ad.appspot.com',
    iosBundleId: 'com.example.flutterEx.RunnerTests',
  );
}
