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
    apiKey: 'AIzaSyARtE18nmR74VU5kkbCN6V0prJ-2IT8oeY',
    appId: '1:944305512903:web:0ce340f3e2ac139c0b39e2',
    messagingSenderId: '944305512903',
    projectId: 'alteratech-22266',
    authDomain: 'alteratech-22266.firebaseapp.com',
    storageBucket: 'alteratech-22266.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAn9rXA_zipP-YwpqKu1L56wj_0ECWHon4',
    appId: '1:944305512903:android:978dc99891bde5d90b39e2',
    messagingSenderId: '944305512903',
    projectId: 'alteratech-22266',
    storageBucket: 'alteratech-22266.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAUA3Hyk6CTXEX9wYpNfcImI-fywEB1dw0',
    appId: '1:944305512903:ios:6b26f968d419cfce0b39e2',
    messagingSenderId: '944305512903',
    projectId: 'alteratech-22266',
    storageBucket: 'alteratech-22266.appspot.com',
    iosClientId: '944305512903-cjrvg32ft7co1s2uvrgf7v3vmivoequi.apps.googleusercontent.com',
    iosBundleId: 'com.example.newLampa',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAUA3Hyk6CTXEX9wYpNfcImI-fywEB1dw0',
    appId: '1:944305512903:ios:6b26f968d419cfce0b39e2',
    messagingSenderId: '944305512903',
    projectId: 'alteratech-22266',
    storageBucket: 'alteratech-22266.appspot.com',
    iosClientId: '944305512903-cjrvg32ft7co1s2uvrgf7v3vmivoequi.apps.googleusercontent.com',
    iosBundleId: 'com.example.newLampa',
  );
}