import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(WinMapApp());
}

class WinMapApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WIN MAP',
      theme: ThemeData.dark(),
      home: WalletScreen(),
    );
  }
}

class WalletScreen extends StatelessWidget {
  final balanceRef = FirebaseFirestore.instance.collection('wallet').doc('main_balance');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text('WIN MAP', style: TextStyle(fontWeight: FontWeight.bold)), centerTitle: true, backgroundColor: Colors.black),
      body: Center(
        child: StreamBuilder<DocumentSnapshot>(
          stream: balanceRef.snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return CircularProgressIndicator();
            var amount = snapshot.data!.data() != null ? (snapshot.data!.data() as Map)['amount'] ?? 0 : 0;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('TOTAL BALANCE', style: TextStyle(color: Colors.grey, letterSpacing: 2)),
                SizedBox(height: 10),
                Text('\$ $amount', style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.greenAccent)),
                SizedBox(height: 30),
                Text('This balance is REAL - updates from Firebase', style: TextStyle(color: Colors.white54)),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => balanceRef.set({'amount': FieldValue.increment(10)}),
                  child: Text('ADD REAL \$10'),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
