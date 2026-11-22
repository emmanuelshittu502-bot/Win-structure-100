import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
  } catch (e) {
    debugPrint('Firebase: $e');
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
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0A1931),
        primaryColor: const Color(0xFFD4AF37),
      ),
      home: const MainNavigation(),
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});
  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _index = 0;
  final screens = [
    const OgaDashboard(),
    const WardsScreen(),
    const AgentsScreen(),
    const SettlementScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_index],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF0A1931),
        selectedItemColor: const Color(0xFFD4AF37),
        unselectedItemColor: Colors.white54,
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Oga'),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Wards'),
          BottomNavigationBarItem(icon: Icon(Icons.groups), label: 'Agents'),
          BottomNavigationBarItem(icon: Icon(Icons.payments), label: 'Money'),
        ],
      ),
    );
  }
}

// 1. OGA DASHBOARD
class OgaDashboard extends StatelessWidget {
  const OgaDashboard({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('WIN STRUCTURE 100 - B-ONE', style: TextStyle(color: Color(0xFFD4AF37))), backgroundColor: const Color(0xFF0A1931), centerTitle: true),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('wards').snapshots(),
        builder: (context, snap) {
          final wards = snap.data?.docs.length ?? 0;
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(children: [
              _statCard('Total Wards', '$wards', Icons.map),
              _statCard('Target Structure', '100 Units', Icons.flag),
              _statCard('Jos North / Jos South', 'Plateau State', Icons.location_on),
              const SizedBox(height: 20),
              Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: const Color(0xFFD4AF37).withOpacity(0.1), borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFFD4AF37))), child: const Column(children: [
                Text('B-ONE COMMAND ACTIVE', style: TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold, fontSize: 18)),
                SizedBox(height: 8),
                Text('Firebase: b-one-project-2678d\nPackage: com.bone.winstructure', style: TextStyle(color: Colors.white70), textAlign: TextAlign.center),
              ])),
            ]),
          );
        },
      ),
    );
  }
  Widget _statCard(String title, String value, IconData icon) {
    return Card(color: Colors.white10, margin: const EdgeInsets.only(bottom: 12), child: ListTile(leading: Icon(icon, color: const Color(0xFFD4AF37)), title: Text(title, style: const TextStyle(color: Colors.white70)), subtitle: Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18))));
  }
}

// 2. WARDS SCREEN
class WardsScreen extends StatelessWidget {
  const WardsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Wards & PUs'), backgroundColor: const Color(0xFF0A1931)),
      floatingActionButton: FloatingActionButton(backgroundColor: const Color(0xFFD4AF37), child: const Icon(Icons.add), onPressed: () => FirebaseFirestore.instance.collection('wards').add({'name': 'New Ward ${DateTime.now().hour}:${DateTime.now().minute}', 'pus': 10, 'created': FieldValue.serverTimestamp()})),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('wards').orderBy('created', descending: true).snapshots(),
        builder: (context, snap) {
          if (!snap.hasData) return const Center(child: CircularProgressIndicator(color: Color(0xFFD4AF37)));
          final docs = snap.data!.docs;
          if (docs.isEmpty) return const Center(child: Text('No Wards Yet - Tap + to Add', style: TextStyle(color: Colors.white)));
          return ListView.builder(itemCount: docs.length, itemBuilder: (context, i) {
            final data = docs[i].data() as Map<String, dynamic>;
            return ListTile(title: Text(data['name'] ?? 'Ward', style: const TextStyle(color: Colors.white)), subtitle: Text('${data['pus'] ?? 0} PUs', style: const TextStyle(color: Colors.white70)), trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white54, size: 16));
          });
        },
      ),
    );
  }
}

// 3. AGENTS SCREEN
class AgentsScreen extends StatelessWidget {
  const AgentsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Agents Structure'), backgroundColor: const Color(0xFF0A1931)),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('agents').snapshots(),
        builder: (context, snap) {
          final count = snap.data?.docs.length ?? 0;
          return ListView(children: [
            Padding(padding: const EdgeInsets.all(16), child: Text('Total Agents: $count / 100', style: const TextStyle(color: Color(0xFFD4AF37), fontSize: 20, fontWeight: FontWeight.bold))),
            ...?snap.data?.docs.map((d) {
              final data = d.data() as Map<String, dynamic>;
              return Card(color: Colors.white10, margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4), child: ListTile(title: Text(data['name'] ?? 'Agent', style: const TextStyle(color: Colors.white)), subtitle: Text(data['phone'] ?? 'No phone', style: const TextStyle(color: Colors.white70))));
            }),
          ]);
        },
      ),
      floatingActionButton: FloatingActionButton(backgroundColor: const Color(0xFFD4AF37), child: const Icon(Icons.person_add), onPressed: () => FirebaseFirestore.instance.collection('agents').add({'name': 'Agent ${DateTime.now().second}', 'phone': '090${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}', 'ward': 'Jos North'})),
    );
  }
}

// 4. SETTLEMENT / MONEY CUT - with your 9066610477
class SettlementScreen extends StatelessWidget {
  const SettlementScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settlement - B-ONE Cut'), backgroundColor: const Color(0xFF0A1931)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(padding: const EdgeInsets.all(20), decoration: BoxDecoration(color: const Color(0xFFD4AF37), borderRadius: BorderRadius.circular(12)), child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('B-ONE ACCOUNT', style: TextStyle(color: Color(0xFF0A1931), fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('9066610477', style: TextStyle(color: Color(0xFF0A1931), fontSize: 28, fontWeight: FontWeight.bold, letterSpacing: 2)),
            Text('Moniepoint - Bone Win Structure', style: TextStyle(color: Color(0xFF0A1931))),
          ])),
          const SizedBox(height: 20),
          const Text('Quick Calculator - 100 Structure Cut', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 10),
          const Text('Enter total money, app calculates B-ONE % automatically', style: TextStyle(color: Colors.white70)),
        ]),
      ),
    );
  }
}
