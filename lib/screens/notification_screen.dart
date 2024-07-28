import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  // Example list of notifications
  final List<String> _notifications = List.generate(10, (index) => 'Notification $index');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
        itemCount: _notifications.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(_notifications[index]), // Unique key for each notification
            direction: DismissDirection.endToStart,
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            confirmDismiss: (direction) async {
              if (direction == DismissDirection.endToStart) {
                // Show a confirmation dialog
                return await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Confirm Deletion'),
                      content: const Text('Are you sure you want to delete this notification?'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(false), // Cancel
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(true), // Delete
                          child: const Text('Yes'),
                        ),
                      ],
                    );
                  },
                );
              }
              return false;
            },
            onDismissed: (direction) {
              // Remove the notification from the list
              setState(() {
                _notifications.removeAt(index);
              });

              // Optionally show a snackbar
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Notification $index deleted'),
                ),
              );
            },
            child: ListTile(
              leading: const Icon(Icons.notification_important),
              title: Text(_notifications[index]),
              subtitle: const Text('Details of the notification'),
              onTap: () {
                // Handle notification tap
              },
            ),
          );
        },
      ),
    );
  }
}
