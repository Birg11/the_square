import 'package:flutter/material.dart';

class TaskDialog extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onSubmit;
  final VoidCallback onCancel;
  final VoidCallback onDelete;

  const TaskDialog({
    Key? key,
    required this.controller,
    required this.onSubmit,
    required this.onCancel,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: const Center(child: Text("Edit Task")),
      content: TextField(
        controller: controller,
        decoration: const InputDecoration(labelText: "Task Name"),
      ),
      actions: [
        TextButton(
          onPressed: () {
            onDelete(); // Trigger task deletion
            Navigator.pop(context); // Close the dialog
          },
          child: const Text(
            "Delete",
            style: TextStyle(color: Colors.red),
          ),
        ),
        TextButton(
          onPressed: onCancel,
          child: const Text(
            "Cancel",
            style: TextStyle(color: Colors.black),
          ),
        ),
        TextButton(
          onPressed: () {
            onSubmit(controller.text);
            Navigator.pop(context);
          },
          child: const Text(
            "Save",
            style: TextStyle(color: Colors.amber),
          ),
        ),
      ],
    );
  }
}
