import 'package:flutter/material.dart';

class TodoDeleteBox extends StatelessWidget {
  final dynamic onPressed;
  const TodoDeleteBox({
    Key? key,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Todo'),
      content: Text('Are you sure you want to delete this?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancel'),
        ),
        TextButton(onPressed: onPressed, child: Text('Delete'))
      ],
    );
  }
}
