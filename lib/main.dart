import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try { await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform); } catch(e){}
  runApp(BOneRealApp());
}

class BOneRealApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(debugShowCheckedModeBanner: false, home: LoginReal());
}

class LoginReal extends StatefulWidget { @override State<LoginReal> createState()=>_LoginRealState();}
class _LoginRealState extends State<LoginReal>{
  TextEditingController phone = TextEditingController();
  bool isAdmin = false;
  @override Widget build(BuildContext context){
    return Scaffold(backgroundColor: Color(0xFF0A1931), body: Padding(padding: EdgeInsets.all(24), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text('B-ONE REAL WALLET', style: TextStyle(color: Color(0xFFD4AF37), fontSize:26, fontWeight: FontWeight.bold)),
      SizedBox(height:20),
      TextField(controller: phone, keyboardType: TextInputType.phone, style: TextStyle(color: Colors.white), decoration: InputDecoration(labelText: 'Your Phone Number', hintText: '080...', border: OutlineInputBorder(), labelStyle: TextStyle(color: Colors.white70))),
      SizedBox(height:12),
      Row(children: [Checkbox(value: isAdmin, onChanged: (v)=>setState(()=>isAdmin=v!), activeColor: Color(0xFFD4AF37)), Text('I am ADMIN (B-ONE)', style: TextStyle(color: Colors.white54))]),
      SizedBox(height:20),
      SizedBox(width: double.infinity, child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFD4AF37), padding: EdgeInsets.all(16)), onPressed: (){
        if(phone.text.isEmpty) return;
        if(isAdmin && phone.text!='9066610477'){ ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Admin must login with 9066610477'))); return; }
        FirebaseFirestore.instance.collection('users').doc(phone.text).set({'phone':phone.text, 'balance':0, 'created':FieldValue.serverTimestamp()}, SetOptions(merge:true));
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> isAdmin ? AdminApproveScreen() : WalletRealScreen(phone: phone.text)));
      }, child: Text('ENTER', style: TextStyle(color: Color(0xFF0A1931), fontWeight: FontWeight.bold)))) ,
      SizedBox(height:12),
      Text('User balance = 0 until admin approves deposit to 9066610477\nNo fake balance', style: TextStyle(color: Colors.white38, fontSize:11), textAlign: TextAlign.center)
    ])));
  }
}

class WalletRealScreen extends StatelessWidget{
  final String phone; WalletRealScreen({required this.phone});
  void depositReal(BuildContext ctx){
    TextEditingController amtCtrl = TextEditingController();
    showModalBottomSheet(context: ctx, backgroundColor: Color(0xFF0A1931), isScrollControlled: true, builder: (c)=>Padding(padding: EdgeInsets.only(bottom: MediaQuery.of(c).viewInsets.bottom, left:16,right:16,top:24), child: Column(mainAxisSize: MainAxisSize.min, children: [
      Text('DEPOSIT', style: TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold, fontSize:18)),
      SizedBox(height:12),
      Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(8)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Transfer to', style: TextStyle(color: Colors.white54, fontSize:12)),
        Text('Moniepoint - 9066610477 - B-ONE', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize:16)),
      ])),
      SizedBox(height:12),
      TextField(controller: amtCtrl, keyboardType: TextInputType.number, style: TextStyle(color: Colors.white), decoration: InputDecoration(prefixText: '₦ ', labelText: 'Amount', border: OutlineInputBorder())),
      SizedBox(height:12),
      SizedBox(width: double.infinity, child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFD4AF37), padding: EdgeInsets.all(16)), onPressed: (){
        double amt = double.tryParse(amtCtrl.text)??0;
        if(amt<=0) return;
        FirebaseFirestore.instance.collection('deposits').add({'phone':phone, 'amount':amt, 'to_account':'9066610477', 'status':'PENDING', 'time':FieldValue.serverTimestamp()});
        Navigator.pop(c);
        ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(content: Text('Deposit request sent! Wait for approval'), backgroundColor: Colors.orange));
      }, child: Text('DEPOSIT', style: TextStyle(color: Color(0xFF0A1931), fontWeight: FontWeight.bold, fontSize:16)))),
      SizedBox(height:30),
    ])));
  }
  void sendReal(BuildContext ctx, double myBalance){
    TextEditingController toCtrl=TextEditingController(); TextEditingController amtCtrl=TextEditingController();
    showModalBottomSheet(context: ctx, isScrollControlled: true, backgroundColor: Color(0xFF0A1931), builder: (c)=>StatefulBuilder(builder: (c,setM){
      double amt=double.tryParse(amtCtrl.text)??0; double cut=amt*0.02; double sendAmt=amt-cut;
      return Padding(padding: EdgeInsets.only(bottom: MediaQuery.of(c).viewInsets.bottom, left:16,right:16,top:24), child: Column(mainAxisSize: MainAxisSize.min, children: [
        Text('SEND TO ANYBODY - REAL', style: TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold)),
        SizedBox(height:12),
        TextField(controller: toCtrl, keyboardType: TextInputType.phone, style: TextStyle(color: Colors.white), decoration: InputDecoration(labelText: 'Receiver Phone', border: OutlineInputBorder())),
        TextField(controller: amtCtrl, keyboardType: TextInputType.number, style: TextStyle(color: Colors.white), onChanged: (v)=>setM((){}), decoration: InputDecoration(prefixText: '₦ ', labelText: 'Amount', border: OutlineInputBorder())),
        if(amt>0) Container(margin: EdgeInsets.only(top:12), padding: EdgeInsets.all(10), decoration: BoxDecoration(border: Border.all(color: Color(0xFFD4AF37)), borderRadius: BorderRadius.circular(8)), child: Column(children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('Receiver gets', style: TextStyle(color: Colors.white70)), Text('₦${sendAmt.toStringAsFixed(2)}', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('B-ONE 2% -> 9066610477', style: TextStyle(color: Colors.white70, fontSize:12)), Text('₦${cut.toStringAsFixed(2)}', style: TextStyle(color: Color(0xFFD4AF37)))]),
        ])),
        SizedBox(height:12),
        SizedBox(width: double.infinity, child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFD4AF37)), onPressed: () async {
          if(amt<=0 || amt>myBalance || toCtrl.text.isEmpty) return;
          var receiverDoc = await FirebaseFirestore.instance.collection('users').doc(toCtrl.text).get();
          if(!receiverDoc.exists){ ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(content: Text('Receiver not registered'))); return; }
          await FirebaseFirestore.instance.collection('users').doc(phone).update({'balance': FieldValue.increment(-amt)});
          await FirebaseFirestore.instance.collection('users').doc(toCtrl.text).update({'balance': FieldValue.increment(sendAmt)});
          await FirebaseFirestore.instance.collection('users').doc('9066610477').set({'phone':'9066610477','balance':0}, SetOptions(merge:true));
          await FirebaseFirestore.instance.collection('users').doc('9066610477').update({'balance': FieldValue.increment(cut)});
          await FirebaseFirestore.instance.collection('transfers').add({'from':phone,'to':toCtrl.text,'amount':amt,'cut':cut,'bone_account':'9066610477','time':FieldValue.serverTimestamp()});
          Navigator.pop(c);
        }, child: Text('SEND REAL MONEY'))),
        SizedBox(height:30),
      ]));
    }));
  }
  @override Widget build(BuildContext context){
    return StreamBuilder<DocumentSnapshot>(stream: FirebaseFirestore.instance.collection('users').doc(phone).snapshots(), builder: (c,snap){
      double bal = 0; if(snap.hasData && snap.data!.data()!=null){ var d=snap.data!.data() as Map; bal = (d['balance']??0).toDouble(); }
      return Scaffold(backgroundColor: Color(0xFF0A1931), appBar: AppBar(backgroundColor: Color(0xFF0A1931), title: Text('WALLET $phone', style: TextStyle(color: Colors.white, fontSize:14))),
        body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
          Container(width: double.infinity, padding: EdgeInsets.all(20), decoration: BoxDecoration(color: Color(0xFFD4AF37), borderRadius: BorderRadius.circular(16)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('REAL BALANCE - From Firebase', style: TextStyle(color: Color(0xFF0A1931), fontSize:12)),
            Text('₦ ${bal.toStringAsFixed(2)}', style: TextStyle(color: Color(0xFF0A1931), fontSize:36, fontWeight: FontWeight.bold)),
            Text('Backed by 9066610477 Moniepoint', style: TextStyle(color: Color(0xFF0A1931).withOpacity(0.7), fontSize:11)),
          ])),
          SizedBox(height:16),
          Row(children: [Expanded(child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFD4AF37), padding: EdgeInsets.all(16)), onPressed: ()=>depositReal(context), child: Text('DEPOSIT', style: TextStyle(color: Color(0xFF0A1931), fontWeight: FontWeight.bold, fontSize:12)))), SizedBox(width:8), Expanded(child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.white10, padding: EdgeInsets.all(16)), onPressed: ()=>sendReal(context, bal), child: Text('SEND', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize:12))))]),
        ])),
      );
    });
  }
}

class AdminApproveScreen extends StatelessWidget{
  @override Widget build(BuildContext context){
    return Scaffold(backgroundColor: Color(0xFF0A1931), appBar: AppBar(backgroundColor: Color(0xFF0A1931), title: Text('ADMIN - 9066610477', style: TextStyle(color: Color(0xFFD4AF37), fontSize:12)))),
      body: Column(children: [
        StreamBuilder<DocumentSnapshot>(stream: FirebaseFirestore.instance.collection('users').doc('9066610477').snapshots(), builder: (c,s){ double b=0; if(s.hasData && s.data!.data()!=null) b=(s.data!.data() as Map)['balance']?.toDouble()??0; return Container(width: double.infinity, margin: EdgeInsets.all(16), padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Color(0xFFD4AF37), borderRadius: BorderRadius.circular(12)), child: Column(children: [Text('YOUR 2% EARNINGS IN 9066610477', style: TextStyle(fontSize:11)), Text('₦ ${b.toStringAsFixed(2)}', style: TextStyle(fontSize:28, fontWeight: FontWeight.bold))])) ;}),
        Expanded(child: StreamBuilder<QuerySnapshot>(stream: FirebaseFirestore.instance.collection('deposits').where('status', isEqualTo: 'PENDING').snapshots(), builder: (c,snap){
          if(!snap.hasData) return Center(child: CircularProgressIndicator(color: Color(0xFFD4AF37)));
          var docs=snap.data!.docs;
          if(docs.isEmpty) return Center(child: Text('No pending deposits', style: TextStyle(color: Colors.white54)));
          return ListView.builder(itemCount: docs.length, itemBuilder: (c,i){
            var d=docs[i].data() as Map;
            return Card(color: Colors.white10, margin: EdgeInsets.symmetric(horizontal:16, vertical:6), child: ListTile(title: Text('${d['phone']} sent ₦${d['amount']}', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)), subtitle: Text('To 9066610477 - Check Moniepoint alert', style: TextStyle(color: Colors.white54, fontSize:11)), trailing: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.green), onPressed: () async {
              await FirebaseFirestore.instance.collection('users').doc(d['phone']).update({'balance': FieldValue.increment(d['amount'])});
              await FirebaseFirestore.instance.collection('deposits').doc(docs[i].id).update({'status':'APPROVED'});
            }, child: Text('APPROVE'))));
          });
        })),
      ]),
    );
  }
}
