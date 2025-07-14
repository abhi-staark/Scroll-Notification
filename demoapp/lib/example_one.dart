import 'package:flutter/material.dart';

/// 📝 LoadMoreListScreen demonstrates how to:
/// ✅ Listen to scroll position using NotificationListener<ScrollNotification>.
/// ✅ Detect when the user scrolls near the bottom of the list.
/// ✅ Automatically load more data and update the list dynamically.
/// 
/// 📌 How it works:
/// - Starts with a list of 20 items.
/// - When the user scrolls to within 50 pixels of the bottom:
///   → Calls `_loadMore()` to simulate fetching new data.
/// - Shows a loading indicator at the bottom while loading.
/// - Adds 10 new items each time.
/// 
/// 🧩 This pattern is useful for:
/// - Infinite scroll feeds.
/// - Lazy loading long lists.
/// - Pagination in apps.
class LoadMoreListScreen extends StatefulWidget {
  const LoadMoreListScreen({super.key});

  @override
  State<LoadMoreListScreen> createState() => _LoadMoreListScreenState();
}

class _LoadMoreListScreenState extends State<LoadMoreListScreen> {
  // Initial list of items.
  List<int> items = List.generate(20, (index) => index);

  // Flag to track if data is currently loading.
  bool isLoading = false;

  /// Method to load more items.
  /// Prevents multiple triggers using `isLoading` flag.
  Future<void> _loadMore() async {
    if (isLoading) return;

    setState(() => isLoading = true);

    // Simulate a network delay.
    await Future.delayed(const Duration(seconds: 2));

    // Generate new items.
    final nextItems = List.generate(10, (index) => items.length + index);

    // Add them to the list and stop loading.
    setState(() {
      items.addAll(nextItems);
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Load More on Scroll')),
      body: NotificationListener<ScrollNotification>(
        // Listen for scroll updates.
        onNotification: (notification) {
          if (notification is ScrollUpdateNotification) {
            // If user scrolls near the bottom, load more data.
            if (notification.metrics.pixels >=
                notification.metrics.maxScrollExtent - 50) {
              _loadMore();
            }
          }
          // Return false to allow other notifications to propagate.
          return false;
        },
        child: ListView.builder(
          // Show one extra item for the loading indicator if loading.
          itemCount: isLoading ? items.length + 1 : items.length,
          itemBuilder: (context, index) {
            // Show loading indicator at the end.
            if (index == items.length) {
              return const Padding(
                padding: EdgeInsets.all(16),
                child: Center(child: CircularProgressIndicator()),
              );
            }
            // Display list item.
            return ListTile(title: Text('Item ${items[index]}'));
          },
        ),
      ),
    );
  }
}
