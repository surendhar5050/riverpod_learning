import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final dateProvider = Provider<DateTime>((ref) => DateTime.now());

class Example1 extends ConsumerWidget {
  const Example1({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentDate = ref.watch(dateProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Title')),
      body: Center(
        child: Text(
          currentDate.toIso8601String(),
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
    );
  }
}
