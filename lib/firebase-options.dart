import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    return const FirebaseOptions(
      apiKey: "AIzaSyBONE-Real-Key-123456",
      appId: "1:987654321:android:bone123",
      messagingSenderId: "987654321",
      projectId: "b-one-wallet-real",
      storageBucket: "b-one-wallet-real.appspot.com",
    );
  }
}
