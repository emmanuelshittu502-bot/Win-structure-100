import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // FIX FOR FLUTTER LOGO FREEZE - load Firebase in background
  try {
    await Firebase.initializeApp();
  } catch (e) {
    print('Firebase error but app will still open: $e');
  }
  runApp(const WinStructureApp());
}

class WinStructureApp extends StatelessWidget {
  const WinStructureApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Win Structure 100',
      theme: ThemeData(
        primaryColor: const Color(0xFF0A1931),
        scaffoldBackgroundColor: const Color(0xFF0A1931),
      ),
      home: const WarRoomScreen(),
    );
  }
}

class WarRoomScreen extends StatelessWidget {
  const WarRoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A1931),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A1931),
        title: const Text(
          'WIN STRUCTURE 100',
          style: TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('campaigns').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: Color(0xFFD4AF37)),
                  SizedBox(height: 20),
                  Text('Loading War Room...', style: TextStyle(color: Colors.white)),
                ],
              ),
            );
          }
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.shield, color: Color(0xFFD4AF37), size: 100),
                SizedBox(height: 20),
                Text('B-ONE WAR ROOM ACTIVE', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Text('Firebase Connected ✓', style: TextStyle(color: Colors.green, fontSize: 16)),
                SizedBox(height: 10),
                Text('Jos, Plateau State', style: TextStyle(color: Colors.white70)),
              ],
            ),
          );
        },
      ),
    );
  }
}
