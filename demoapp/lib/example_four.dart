import 'package:flutter/material.dart';

/// 📝 This screen demonstrates how to:
/// ✅ Listen to scroll position using NotificationListener<ScrollNotification>.
/// ✅ Track current scroll offset (in pixels).
/// ✅ Trigger an event when the scroll passes a certain threshold (200 pixels).
/// 
/// 📌 When the user scrolls past 200 pixels:
/// - The AppBar color changes from blue to deep orange.
/// 
/// This pattern can be used to:
/// - Show/hide widgets.
/// - Start animations.
/// - Load data or fire events dynamically based on scroll.
class TriggerScrollEventScreen extends StatefulWidget {
  const TriggerScrollEventScreen({super.key});

  @override
  State<TriggerScrollEventScreen> createState() => _TriggerScrollEventScreenState();
}

class _TriggerScrollEventScreenState extends State<TriggerScrollEventScreen> {
  // Tracks the current vertical scroll offset in pixels.
  double _scrollOffset = 0.0;

  // Flag to indicate if we've scrolled past the threshold.
  bool _isPastThreshold = false;

  // The threshold scroll offset where the event should trigger.
  static const double threshold = 200.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar color changes dynamically based on scroll offset.
      appBar: AppBar(
        title: const Text('Trigger Event on Scroll'),
        backgroundColor: _isPastThreshold ? Colors.deepOrange : Colors.blue,
      ),
      body: NotificationListener<ScrollNotification>(
        // Called whenever the scroll position changes.
        onNotification: (notification) {
          if (notification is ScrollUpdateNotification) {
            setState(() {
              _scrollOffset = notification.metrics.pixels;
              // Update flag if scrolled past threshold.
              _isPastThreshold = _scrollOffset > threshold;
            });
          }
          // Return false so other scroll listeners (if any) can also receive the event.
          return false;
        },
        child: ListView.builder(
          itemCount: 50,
          itemBuilder: (context, index) => ListTile(
            title: Text('Item $index'),
          ),
        ),
      ),
    );
  }
}
