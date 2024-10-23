import 'package:flutter/material.dart';

void showBlogModal(BuildContext context, List<String> data, VoidCallback onClose) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Hello User"),
        content: SingleChildScrollView( // Add SingleChildScrollView here
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: data.map((item) {
              return Text(item);
            }).toList(),
          ),
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
