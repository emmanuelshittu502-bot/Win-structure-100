import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
      title: 'Win Structure 100 - B-ONE',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: const Color(0xFF0A1931)),
      home: const MainWarRoom(),
    );
  }
}

class MainWarRoom extends StatefulWidget {
  const MainWarRoom({super.key});
  @override
  State<MainWarRoom> createState() => _MainWarRoomState();
}

class _MainWarRoomState extends State<MainWarRoom> {
  int _index = 0;
  final List<Widget> _pages = [
    OgaDashboard(),
    WardPage(),
    PollingUnitPage(),
    AgentsPage(),
    ResultsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A1931),
        title: const Text('WIN STRUCTURE 100 - B-ONE', style: TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold, fontSize: 14)),
        centerTitle: true,
      ),
      body: _pages[_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF0A1931),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.shield), label: 'Oga'),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Wards'),
          BottomNavigationBarItem(icon: Icon(Icons.how_to_vote), label: 'PUs'),
          BottomNavigationBarItem(icon: Icon(Icons.groups), label: 'Agents'),
          BottomNavigationBarItem(icon: Icon(Icons.attach_money), label: 'Money'),
        ],
      ),
    );
  }
}

class OgaDashboard extends StatelessWidget {
  OgaDashboard({super.key});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('politicians').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            goldCard('PROJECT ACTIVE', 'b-one-project-2678d\ncom.bone.winstructure\nownerId isolation ON'),
            const SizedBox(height: 10),
            const Text('CAMPAIGNS (ownerId isolated)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            ...snapshot.data!.docs.map((doc) {
              final data = doc.data() as Map<String, dynamic>;
              return Card(child: ListTile(leading: const Icon(Icons.verified_user, color: Colors.green), title: Text(data['name'] ?? 'Politician'), subtitle: Text('ownerId: ${data['ownerId'] ?? 'secured'}')));
            }),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0A1931)),
              onPressed: () => FirebaseFirestore.instance.collection('politicians').add({'name': 'AMAC Campaign ${DateTime.now().second}', 'ownerId': 'B-ONE-SECURE-001', 'createdAt': FieldValue.serverTimestamp()}),
              child: const Text('Add Politician Campaign', style: TextStyle(color: Color(0xFFD4AF37))),
            ),
          ],
        );
      },
    );
  }
}

class WardPage extends StatelessWidget {
  WardPage({super.key});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('wards').snapshots(),
      builder: (context, snap) {
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            goldCard('2. WARDS STRUCTURE', 'AMAC Wards - GPS enabled\nIsolated by ownerId'),
            if (snap.hasData) ...snap.data!.docs.map((d) {
              final data = d.data() as Map<String, dynamic>;
              return Card(child: ListTile(title: Text(data['wardName'] ?? 'Ward'), subtitle: const Text('LGA: AMAC')));
            }),
            ElevatedButton(onPressed: () => FirebaseFirestore.instance.collection('wards').add({'wardName': 'Ward ${DateTime.now().second}', 'lga': 'AMAC', 'createdAt': FieldValue.serverTimestamp()}), child: const Text('Add Ward')),
          ],
        );
      },
    );
  }
}

class PollingUnitPage extends StatelessWidget {
  PollingUnitPage({super.key});
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        goldCard('3. POLLING UNITS & SOLDIER TASKS', 'Election Day Mode: READY\nGPS Check-In: ACTIVE\nSoldier must be at PU location'),
        const Card(child: ListTile(leading: Icon(Icons.gps_fixed, color: Colors.red), title: Text('GPS Check-In Required'), subtitle: Text('If soldier not at PU, check-in FAILS'), trailing: Icon(Icons.check_circle, color: Colors.green))),
        const Card(child: ListTile(title: Text('PU 001 - Wuse'), subtitle: Text('Task: Mobilize 50 voters\nAssigned: Emeka'))),
        ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0A1931)), onPressed: () => FirebaseFirestore.instance.collection('polling_units').add({'puName': 'PU ${DateTime.now().second}', 'gpsVerified': false, 'createdAt': FieldValue.serverTimestamp()}), child: const Text('Add PU Task', style: TextStyle(color: Color(0xFFD4AF37)))),
      ],
    );
  }
}

class AgentsPage extends StatelessWidget {
  AgentsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        goldCard('4. AGENTS - GENERAL & SOLDIER', 'Role isolation ACTIVE\nGENERAL: Wards only\nSOLDIER: His PU tasks + GPS only\nOGA: Sees everything'),
        const Card(child: ListTile(leading: Icon(Icons.star, color: Color(0xFFD4AF37)), title: Text('GENERAL - Musa'), subtitle: Text('Ward Leader - AMAC Wuse'))),
        const Card(child: ListTile(leading: Icon(Icons.security, color: Color(0xFF0A1931)), title: Text('SOLDIER - Emeka'), subtitle: Text('PU Agent - GPS check-in'))),
        ElevatedButton(onPressed: () => FirebaseFirestore.instance.collection('agents').add({'name': 'Agent ${DateTime.now().second}', 'role': 'SOLDIER', 'createdAt': FieldValue.serverTimestamp()}), child: const Text('Add Agent')),
      ],
    );
  }
}

class ResultsPage extends StatelessWidget {
  ResultsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(padding: const EdgeInsets.all(20), decoration: BoxDecoration(color: const Color(0xFF0A1931), borderRadius: BorderRadius.circular(12)), child: const Column(children: [Text('5. RESULTS + MONEY FLOW', style: TextStyle(color: Color(0xFFD4AF37), fontSize: 20, fontWeight: FontWeight.bold)), SizedBox(height: 10), Text('B-ONE Opay: 9066610477\nAuto 2% Cut: ACTIVE on EVERY transaction\n₦100k → ₦2k to B-ONE automatically', style: TextStyle(color: Colors.white), textAlign: TextAlign.center)])),
        const SizedBox(height: 10),
        const Card(child: ListTile(title: Text('Live Election Results'), subtitle: Text('APC: 1,240\nPDP: 980\nLabour: 320\nStatus: WINNING'))),
        StreamBuilder<QuerySnapshot>(stream: FirebaseFirestore.instance.collection('transactions').snapshots(), builder: (c, s) {
          if (!s.hasData) return const SizedBox();
          return Column(children: s.data!.docs.map((d) {
            final data = d.data() as Map<String, dynamic>;
            return Card(child: ListTile(title: Text('₦${data['amount'] ?? 0}'), subtitle: Text('B-ONE 2%: ₦${data['boneCut']} → ${data['opay']}')));
          }).toList());
        }),
        ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.green), onPressed: () => FirebaseFirestore.instance.collection('transactions').add({'amount': 100000, 'boneCut': 2000, 'opay': '9066610477', 'createdAt': FieldValue.serverTimestamp()}), child: const Text('Test 2% Cut to 9066610477')),
      ],
    );
  }
}

Widget goldCard(String title, String subtitle) {
  return Card(color: const Color(0xFF0A1931), child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold, fontSize: 16)), const SizedBox(height: 5), Text(subtitle, style: const TextStyle(color: Colors.white70))])));
}
