// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyCV0pqHYArA3KmRUkvtkDhKIU1q8mf73uw',
    appId: '1:644828239283:web:b203c212e036bfc51767c6',
    messagingSenderId: '644828239283',
    projectId: 'academex-11418',
    authDomain: 'academex-11418.firebaseapp.com',
    storageBucket: 'academex-11418.firebasestorage.app',
    measurementId: 'G-N54G48YM5C',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBFqAguCU1Ws6JtKWVfogUZ1ejYo1Wjric',
    appId: '1:644828239283:android:6fb1720c207a03e81767c6',
    messagingSenderId: '644828239283',
    projectId: 'academex-11418',
    storageBucket: 'academex-11418.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCegnKxG6WO7Ic9Z2WCEjAPXWKpsJ18fqk',
    appId: '1:644828239283:ios:fa57a0cd887930ae1767c6',
    messagingSenderId: '644828239283',
    projectId: 'academex-11418',
    storageBucket: 'academex-11418.firebasestorage.app',
    iosBundleId: 'com.example.academex',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCegnKxG6WO7Ic9Z2WCEjAPXWKpsJ18fqk',
    appId: '1:644828239283:ios:fa57a0cd887930ae1767c6',
    messagingSenderId: '644828239283',
    projectId: 'academex-11418',
    storageBucket: 'academex-11418.firebasestorage.app',
    iosBundleId: 'com.example.academex',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCV0pqHYArA3KmRUkvtkDhKIU1q8mf73uw',
    appId: '1:644828239283:web:f0fcfc94e8365f6a1767c6',
    messagingSenderId: '644828239283',
    projectId: 'academex-11418',
    authDomain: 'academex-11418.firebaseapp.com',
    storageBucket: 'academex-11418.firebasestorage.app',
    measurementId: 'G-3KH76C8S41',
  );
}
