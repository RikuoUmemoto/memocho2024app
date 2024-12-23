import 'dart:convert';

import 'package:client_example/model/human.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'main.g.dart';

@riverpod
class Response extends _$Response {
  @override
  String build() => '';

  void update(String value) {
    state = value;
  }
}

// class Response extends Notifier<String> {
//   @override
//   String build() => '';
//
//   void update(String value) {
//     state = value;
//   }
// }
// final responseProvider = NotifierProvider<Response, String>(() => Response());

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
final uriJson = Uri.parse('http://10.0.2.2:8080/json');
final uriHoge = Uri.parse('http://10.0.2.2:8080/echo/hoge');

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
                final result = await get(uriRoot);

                ref.read(responseProvider.notifier).update(result);
              },
              child: const Text('/'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final result = await get(uriJson);
                final human = jsonDecode(result) as Map<String, dynamic>;

                ref
                    .read(responseProvider.notifier)
                    .update('name: ${human['name']}\n age: ${human['age']}');
              },
              child: const Text('/json'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final result = await get(uriHoge);

                ref.read(responseProvider.notifier).update(result);
              },
              child: const Text('/echo/hoge'),
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
