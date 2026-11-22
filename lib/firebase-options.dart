import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    return const FirebaseOptions(
      apiKey: "AIzaSyDummyKey-For-Build-12345",
      appId: "1:123456789:android:b1234567890abcdef",
      messagingSenderId: "123456789",
      projectId: "b-one-real-wallet",
      storageBucket: "b-one-real-wallet.appspot.com",
    );
  }
}
