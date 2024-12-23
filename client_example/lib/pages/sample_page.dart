import 'package:client_example/pages/sample_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SamplePage extends ConsumerWidget {
  const SamplePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewState = ref.watch(sampleViewModelProvider);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            viewState.when(
              data: (data) => data.human != null
                  ? Text("${data.human!.name} : ${data.human!.age}")
                  : const CircularProgressIndicator(),
              error: (a, b) => Text(b.toString()),
              loading: () => const CircularProgressIndicator(),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                ref.read(sampleViewModelProvider.notifier).getHuman();
              },
              child: const Text('/json'),
            ),
          ],
        ),
      ),
    );
  }
}
