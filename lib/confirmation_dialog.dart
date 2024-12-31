import 'package:flutter/material.dart';

Future<void> showConfirmationDialog(
    BuildContext context,
    String title,
    String message,
    VoidCallback onConfirm) {

  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          title,
          style: TextStyle(color: Colors.red),
        ),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () {
              onConfirm();  // Call the confirmation action
              Navigator.of(context).pop();  // Close the dialog
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text('Delete'),
          ),
        ],
      );
    },
  );
}
