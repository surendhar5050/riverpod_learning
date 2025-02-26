import 'package:example1/example1.dart';
import 'package:example1/example_2.dart';
import 'package:example1/example_3.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Riverpod Example 1",

      showSemanticsDebugger: false,
      theme: ThemeData.dark(
        useMaterial3: true,
      ).copyWith(primaryColor: Colors.blue),
      themeMode: ThemeMode.dark,

      home: WeatherExample(),
    );
  }
}
