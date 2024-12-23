import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // ignore: unused_element
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ); // Firebaseを初期化
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firestore Test',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Firestore Test Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String _statusMessage = ''; // 状態メッセージ

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Firestoreにデータを追加するメソッド
  Future<void> _addTestData() async {
    try {
      await _firestore.collection('testCollection').add({
        'counter': _counter,
        'timestamp': FieldValue.serverTimestamp(),
      });
      setState(() {
        _statusMessage = 'データが追加されました！';
      });
    } catch (e) {
      setState(() {
        _statusMessage = 'Firestoreへのデータ追加に失敗しました: $e';
      });
    }
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
    _addTestData(); // Firestoreにデータを追加
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            Text(
              _statusMessage, // 状態メッセージの表示
              style: TextStyle(
                  color: _statusMessage.contains('失敗')
                      ? Colors.red
                      : Colors.green),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
