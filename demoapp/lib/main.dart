import 'package:flutter/material.dart';

import 'example_four.dart';
import 'example_one.dart';
import 'example_three.dart';
import 'example_two.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scroll Notification Examples',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeScreen(),
    );
  }
}

/// 🏠 HomeScreen with 4 buttons to navigate to each scroll demo.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scroll Notification Examples')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch, // Buttons fill width
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => const LoadMoreListScreen(),
                ));
              },
              child: const Text('Load More on Scroll'),
            ),
            const SizedBox(height: 12),

            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => const ScrollFabScreen(),
                ));
              },
              child: const Text('Animate FAB on Scroll'),
            ),
            const SizedBox(height: 12),

            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => const ScrollProgressScreen(),
                ));
              },
              child: const Text('Scroll Progress Bar'),
            ),
            const SizedBox(height: 12),

            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => const TriggerScrollEventScreen(),
                ));
              },
              child: const Text('Trigger Event on Scroll'),
            ),
          ],
        ),
      ),
    );
  }
}
