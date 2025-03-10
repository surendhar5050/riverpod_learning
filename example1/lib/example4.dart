import 'package:example1/example_2.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

List<String> names = [
  "Alice",
  "Bob",
  "Charlie",
  "Diana",
  "Ethan",
  "Fiona",
  "George",
  "Hannah",
  "Ian",
  "Jack",
];

final streamCountProvider = StreamProvider(
  (ref) => Stream.periodic(
    Duration(seconds: 1),
    (computationCount) => computationCount + 1,
  ),
);

final namesProvider = FutureProvider((ref) async {
  final count = await ref.watch(streamCountProvider.future);

  print(count);
  return names.getRange(0, count);
});

class Example4 extends ConsumerWidget {
  const Example4({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameProvider = ref.watch(namesProvider);
    return Scaffold(
      appBar: AppBar(title: Text("Stream Provider")),
      body: nameProvider.when(
        data: (data) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return Text(data.elementAt(index));
            },
            itemCount: data.length,
          );
        },
        error: (error, stackTrace) => Text("Reached the end of list"),
        loading: () => LinearProgressIndicator(),
      ),
    );
  }
}
