import 'package:flutter/material.dart';

/// 📝 ScrollProgressScreen demonstrates how to:
/// ✅ Use NotificationListener<ScrollNotification> to track scroll position.
/// ✅ Calculate scroll progress as a percentage (0.0–1.0).
/// ✅ Display a top LinearProgressIndicator reflecting the scroll progress.
///
/// 📌 How it works:
/// - Listens for all scroll events.
/// - Uses notification.metrics.pixels (current scroll offset) and
///   notification.metrics.maxScrollExtent (maximum scroll distance).
/// - Calculates progress: pixels / maxScrollExtent.
/// - Updates _scrollProgress state which rebuilds the LinearProgressIndicator.
///
/// 🧩 This pattern is useful for:
/// - Showing users how far they’ve scrolled in long lists/articles.
/// - Improving perceived UX by providing visual feedback.
class ScrollProgressScreen extends StatefulWidget {
  const ScrollProgressScreen({super.key});

  @override
  State<ScrollProgressScreen> createState() => _ScrollProgressScreenState();
}

class _ScrollProgressScreenState extends State<ScrollProgressScreen> {
  // Holds current scroll progress between 0.0 (top) and 1.0 (bottom).
  double _scrollProgress = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scroll Progress Bar')),

      // Column so we can have a progress bar on top + list below.
      body: Column(
        children: [
          // Top LinearProgressIndicator shows current scroll progress.
          LinearProgressIndicator(
            value: _scrollProgress,
            backgroundColor: Colors.grey.shade300,
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
          ),

          // Expanded widget holds the scrollable ListView.
          Expanded(
            child: NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                // Only calculate if there's something to scroll.
                if (notification.metrics.maxScrollExtent > 0) {
                  // progress = current pixels / max scroll extent.
                  double progress = notification.metrics.pixels /
                      notification.metrics.maxScrollExtent;

                  // Clamp to 0.0–1.0 to avoid over/underflow.
                  setState(() {
                    _scrollProgress = progress.clamp(0.0, 1.0);
                  });
                }
                // Return true so no other listeners process this notification.
                return true;
              },

              // Long scrollable list for demonstration.
              child: ListView.builder(
                itemCount: 50,
                itemBuilder: (context, index) => ListTile(
                  leading: const Icon(Icons.list),
                  title: Text('Item $index'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
