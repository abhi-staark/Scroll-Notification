import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// 📝 ScrollFabScreen demonstrates how to:
/// ✅ Use NotificationListener<ScrollNotification> to detect scroll direction.
/// ✅ Hide the FloatingActionButton (FAB) when scrolling down.
/// ✅ Show the FAB again when scrolling up.
/// ✅ Use AnimatedSlide & AnimatedOpacity for smooth animation.
///
/// 📌 How it works:
/// - Listens for `UserScrollNotification` which contains scroll direction.
/// - If scrolling down (`ScrollDirection.reverse`) → hide FAB.
/// - If scrolling up (`ScrollDirection.forward`) → show FAB.
/// - Applies slide and opacity animations to the FAB.
///
/// 🧩 This pattern is useful for:
/// - Hiding FAB or other UI elements when content is being read.
/// - Creating more space on screen while scrolling.
/// - Smooth user experience for scroll-based UI.
class ScrollFabScreen extends StatefulWidget {
  const ScrollFabScreen({super.key});

  @override
  State<ScrollFabScreen> createState() => _ScrollFabScreenState();
}

class _ScrollFabScreenState extends State<ScrollFabScreen> {
  // Track FAB visibility state.
  bool _isFabVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Animate FAB on Scroll')),

      // Use NotificationListener to listen for scroll direction.
      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is UserScrollNotification) {
            // ScrollDirection.reverse → user scrolling down.
            if (notification.direction == ScrollDirection.reverse) {
              if (_isFabVisible) {
                setState(() => _isFabVisible = false);
              }
            }
            // ScrollDirection.forward → user scrolling up.
            else if (notification.direction == ScrollDirection.forward) {
              if (!_isFabVisible) {
                setState(() => _isFabVisible = true);
              }
            }
          }
          // Return false to allow other notifications to propagate.
          return false;
        },

        // Simple scrollable list for testing.
        child: ListView.builder(
          itemCount: 50,
          itemBuilder: (context, index) => ListTile(
            leading: const Icon(Icons.star),
            title: Text('Item $index'),
          ),
        ),
      ),

      // FloatingActionButton wrapped with Animated widgets for smooth hide/show.
      floatingActionButton: AnimatedSlide(
        duration: const Duration(milliseconds: 300),
        offset: _isFabVisible ? Offset.zero : const Offset(0, 2), // Slide down when hidden.
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          opacity: _isFabVisible ? 1 : 0, // Fade out when hidden.
          child: FloatingActionButton(
            onPressed: () {
              // Show a snackbar on click.
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('FAB clicked!')),
              );
            },
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
