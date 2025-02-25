import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Counter extends StateNotifier<int?> {
  Counter() : super(null);

  void increment() => state = state == null ? 1 : state! + 1;
}

final counterProvider = StateNotifierProvider<Counter, int?>((ref) {
  return Counter();
});

class Example2 extends ConsumerWidget {
  const Example2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Counter App')),
      body: Column(
        children: [
          Consumer(
            builder: (_, WidgetRef ref, __) {
              final counterValue = ref.watch(counterProvider);
              final text =
                  counterValue == null
                      ? "Press the button"
                      : "counter value $counterValue";
              return Text(
                text,
                style: Theme.of(context).textTheme.headlineLarge,
              );
            },
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(counterProvider.notifier).increment();
        },
      ),
    );
  }
}
