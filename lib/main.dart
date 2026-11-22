import 'package:flutter/material.dart';

void main() {
  runApp(const WinStructureApp());
}

class WinStructureApp extends StatelessWidget {
  const WinStructureApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xFF0A1931),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.shield, color: Color(0xFFD4AF37), size: 120),
              SizedBox(height: 20),
              Text('WIN STRUCTURE 100', style: TextStyle(color: Color(0xFFD4AF37), fontSize: 28, fontWeight: FontWeight.bold)),
              Text('B-ONE WAR ROOM', style: TextStyle(color: Colors.white, fontSize: 22)),
              SizedBox(height: 20),
              Text('If you see this, app is FIXED!', style: TextStyle(color: Colors.green, fontSize: 18)),
              Text('9066610477 Moniepoint', style: TextStyle(color: Colors.white70)),
            ],
          ),
        ),
      ),
    );
  }
}
