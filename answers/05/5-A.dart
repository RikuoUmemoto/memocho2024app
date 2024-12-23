import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'API Connection',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

final client = http.Client();
final uriRoot = Uri.parse('http://10.0.2.2:8080/');
final uriHoge = Uri.parse('http://10.0.2.2:8080/echo/hoge');

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _response = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API Connection'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 24),
            Text(
              _response,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                get(uriRoot);
              },
              child: const Text('/'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                get(uriHoge);
              },
              child: const Text('/echo/hoge'),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Future<void> get(Uri uri) async {
    try {
      final response = await client.get(uri);
      setState(() {
        _response = response.body;
      });
    } catch (e) {
      setState(() {
        _response = e.toString();
      });
    }
  }
}

