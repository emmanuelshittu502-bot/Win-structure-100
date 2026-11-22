class MoneyScreen extends StatefulWidget {
  @override
  State<MoneyScreen> createState() => _MoneyScreenState();
}
class _MoneyScreenState extends State<MoneyScreen> {
  TextEditingController totalController = TextEditingController();
  double boneCut = 0;

  void calc() {
    double total = double.tryParse(totalController.text) ?? 0;
    setState(() => boneCut = total * 0.02); // 2% CUT
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
            Container(width: double.infinity, padding: EdgeInsets.all(20), decoration: BoxDecoration(color: Color(0xFFD4AF37), borderRadius: BorderRadius.circular(12)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('B-ONE 2% CUT ACCOUNT', style: TextStyle(color: Color(0xFF0A1931), fontWeight: FontWeight.bold)), SizedBox(height: 8), Text('9066610477', style: TextStyle(color: Color(0xFF0A1931), fontSize: 32, fontWeight: FontWeight.bold)), Text('Moniepoint - 2% of all money goes here', style: TextStyle(color: Color(0xFF0A1931)))])),
            SizedBox(height:20),
            TextField(controller: totalController, keyboardType: TextInputType.number, style: TextStyle(color: Colors.white), decoration: InputDecoration(labelText: 'Enter Total Money (e.g 500000)', labelStyle: TextStyle(color: Colors.white70), border: OutlineInputBorder(), prefixText: '₦ '), onChanged: (v) => calc()),
            SizedBox(height:20),
            Container(width: double.infinity, padding: EdgeInsets.all(20), decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(12), border: Border.all(color: Color(0xFFD4AF37))), child: Column(children: [Text('B-ONE 2% CUT', style: TextStyle(color: Colors.white70)), SizedBox(height:8), Text('₦ ${boneCut.toStringAsFixed(2)}', style: TextStyle(color: Color(0xFFD4AF37), fontSize: 32, fontWeight: FontWeight.bold)), Text('Send this to 9066610477', style: TextStyle(color: Colors.green)) ])),
            SizedBox(height:10),
            Text('Without Firebase: Data stays on each phone. With Firebase later: All agents see same Wards. But for now, NO Firebase = NO BLANK, works for everyone.', style: TextStyle(color: Colors.white54, fontSize: 12), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
