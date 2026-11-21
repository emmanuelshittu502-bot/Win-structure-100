import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const WinStructureApp());
}

class WinStructureApp extends StatelessWidget {
  const WinStructureApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Win Structure 100',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text('WIN STRUCTURE 100 - B-ONE')),
        body: ListView(
          padding: EdgeInsets.all(20),
          children: [
            Card(child: ListTile(
              leading: Icon(Icons.verified, color: Colors.green, size: 40),
              title: Text('Project Active'),
              subtitle: Text('b-one-project-2678d\ncom.bone.winstructure'),
            )),
            SizedBox(height: 20),
            Text('WAR ROOM', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ElevatedButton(onPressed: (){}, child: Text('My Campaigns (ownerId isolated)')),
            ElevatedButton(onPressed: (){}, child: Text('GPS Check-In')),
            SizedBox(height: 20),
            Card(child: Padding(
              padding: EdgeInsets.all(15),
              child: Text('Opay: 9066610477\nAuto 2% Cut: ACTIVE\nReady for APK'),
            )),
          ],
        ),
      ),
    );
  }
}
