import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

part 'main.g.dart';

@riverpod
class Response extends _$Response {
  @override
  String build() => '';

  void update(String value) => state = value;
}

void main() {
  runApp(const ProviderScope(child: MyApp()));
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
final uriJSON = Uri.parse('http://10.0.2.2:8080/json');

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              ref.watch(responseProvider),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () async {
                final response = await get(uriRoot);
                ref.read(responseProvider.notifier).update(response);
              },
              child: const Text('/'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final response = await get(uriHoge);
                ref.read(responseProvider.notifier).update(response);
              },
              child: const Text('/echo/hoge'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              child: const Text('/json'),
              onPressed: () async {
                final response = await get(uriJSON);
                final human = jsonDecode(response) as Map<String, dynamic>;
                ref
                    .read(responseProvider.notifier)
                    .update('name:${human['name']}\nage:${human['age']}');
              },
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Future<String> get(Uri uri) async {
    try {
      final response = await client.get(uri);
      return response.body;
    } catch (e) {
      return e.toString();
    }
  }
}

