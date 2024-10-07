import 'package:flutter/material.dart';

void showCardModal(BuildContext context, String blogContent, String title, String date, String author, VoidCallback onClose) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Column(
          mainAxisSize: MainAxisSize.min, 
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(blogContent),
            const SizedBox(height: 16.0),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                "By $author on $date",
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey[600],
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Close'),
            onPressed: () {
              onClose();
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
