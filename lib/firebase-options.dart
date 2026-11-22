import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      default:
        return android;
    }
  }
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyYOUR_KEY_HERE',
    appId: '1:YOUR_APP_ID_HERE',
    messagingSenderId: 'YOUR_SENDER_ID',
    projectId: 'win-map-real',
    storageBucket: 'win-map-real.appspot.com',
  );
}
