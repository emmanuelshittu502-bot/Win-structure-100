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
      title: 'Win Structure 100',
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
  final screens = [OgaScreen(), WardsScreen(), AgentsScreen(), MoneyScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_index],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF0A1931),
        selectedItemColor: Color(0xFFD4AF37),
        unselectedItemColor: Colors.white54,
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Oga'),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Wards'),
          BottomNavigationBarItem(icon: Icon(Icons.groups), label: 'Agents'),
          BottomNavigationBarItem(icon: Icon(Icons.payments), label: 'Money'),
        ],
      ),
    );
  }
}

class OgaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Color(0xFF0A1931),
      appBar: AppBar(title: Text('WIN STRUCTURE 100 - B-ONE', style: TextStyle(color: Color(0xFFD4AF37))), backgroundColor: Color(0xFF0A1931), centerTitle: true),
      body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
        Card(color: Colors.white10, child: ListTile(leading: Icon(Icons.flag, color: Color(0xFFD4AF37)), title: Text('Target Structure', style: TextStyle(color: Colors.white70)), subtitle: Text('100 Units - Jos North/South', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)))),
        Card(color: Colors.white10, child: ListTile(leading: Icon(Icons.verified, color: Color(0xFFD4AF37)), title: Text('Status', style: TextStyle(color: Colors.white70)), subtitle: Text('FIXED - APP OPENING', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 18)))),
      ])),
    );
  }
}

class WardsScreen extends StatefulWidget {
  @override
  State<WardsScreen> createState() => _WardsScreenState();
}
class _WardsScreenState extends State<WardsScreen> {
  List<String> wards = ['Jos North - Ward 1', 'Jos South - Ward 2', 'Jos North - Ward 3'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Color(0xFF0A1931), appBar: AppBar(title: Text('Wards & PUs'), backgroundColor: Color(0xFF0A1931)),
      floatingActionButton: FloatingActionButton(backgroundColor: Color(0xFFD4AF37), child: Icon(Icons.add), onPressed: () => setState(() => wards.add('New Ward ${wards.length + 1}'))),
      body: ListView.builder(itemCount: wards.length, itemBuilder: (c,i) => Card(color: Colors.white10, margin: EdgeInsets.symmetric(horizontal:16, vertical:4), child: ListTile(title: Text(wards[i], style: TextStyle(color: Colors.white)), subtitle: Text('10 PUs - Structure Active', style: TextStyle(color: Colors.white70)), trailing: Icon(Icons.check_circle, color: Colors.green)))) ,
    );
  }
}

class AgentsScreen extends StatefulWidget {
  @override
  State<AgentsScreen> createState() => _AgentsScreenState();
}
class _AgentsScreenState extends State<AgentsScreen> {
  List<Map<String,String>> agents = [{'name':'Agent Musa','phone':'09011111111'},{'name':'Agent James','phone':'09022222222'}];
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Color(0xFF0A1931), appBar: AppBar(title: Text('Agents Structure - 100'), backgroundColor: Color(0xFF0A1931)),
      floatingActionButton: FloatingActionButton(backgroundColor: Color(0xFFD4AF37), child: Icon(Icons.person_add), onPressed: () => setState(() => agents.add({'name':'Agent ${agents.length+1}','phone':'090${DateTime.now().millisecond}'}))),
      body: Column(children: [
        Padding(padding: EdgeInsets.all(16), child: Text('Total Agents: ${agents.length} / 100', style: TextStyle(color: Color(0xFFD4AF37), fontSize: 20, fontWeight: FontWeight.bold))),
        Expanded(child: ListView.builder(itemCount: agents.length, itemBuilder: (c,i) => Card(color: Colors.white10, margin: EdgeInsets.symmetric(horizontal:16, vertical:4), child: ListTile(leading: CircleAvatar(backgroundColor: Color(0xFFD4AF37), child: Text(agents[i]['name']![0])), title: Text(agents[i]['name']!, style: TextStyle(color: Colors.white)), subtitle: Text(agents[i]['phone']!, style: TextStyle(color: Colors.white70)))))),
      ]),
    );
  }
}

class MoneyScreen extends StatefulWidget {
  @override
  State<MoneyScreen> createState() => _MoneyScreenState();
}
class _MoneyScreenState extends State<MoneyScreen> {
  TextEditingController totalController = TextEditingController();
  double boneCut = 0;

  void calc() {
    double total = double.tryParse(totalController.text) ?? 0;
    setState(() {
      boneCut = total * 0.02;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0A1931),
      appBar: AppBar(title: Text('Settlement - 2% B-ONE'), backgroundColor: Color(0xFF0A1931)),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Container(width: double.infinity, padding: EdgeInsets.all(20), decoration: BoxDecoration(color: Color(0xFFD4AF37), borderRadius: BorderRadius.circular(12)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('B-ONE 2% CUT ACCOUNT', style: TextStyle(color: Color(0xFF0A1931), fontWeight: FontWeight.bold)), SizedBox(height: 8), Text('9066610477', style: TextStyle(color: Color(0xFF0A1931), fontSize: 32, fontWeight: FontWeight.bold)), Text('Moniepoint - 2% of all money', style: TextStyle(color: Color(0xFF0A1931)))])),
            SizedBox(height: 20),
            TextField(controller: totalController, keyboardType: TextInputType.number, style: TextStyle(color: Colors.white), decoration: InputDecoration(labelText: 'Enter Total Money', labelStyle: TextStyle(color: Colors.white70), border: OutlineInputBorder(), prefixText: '₦ '), onChanged: (v) => calc()),
            SizedBox(height: 20),
            Container(width: double.infinity, padding: EdgeInsets.all(20), decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(12), border: Border.all(color: Color(0xFFD4AF37))), child: Column(children: [Text('B-ONE 2% CUT', style: TextStyle(color: Colors.white70)), SizedBox(height: 8), Text('₦ ${boneCut.toStringAsFixed(2)}', style: TextStyle(color: Color(0xFFD4AF37), fontSize: 32, fontWeight: FontWeight.bold)), Text('Send to 9066610477', style: TextStyle(color: Colors.green))])),
            SizedBox(height: 10),
            Text('No Firebase needed. Works offline. Share APK on WhatsApp.', style: TextStyle(color: Colors.white54, fontSize: 12), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
