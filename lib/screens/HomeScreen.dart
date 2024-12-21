import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_square/widgets/quadrant.dart';
import 'package:the_square/widgets/task_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, List<String>> tasks = {
    'Quadrant1': [],
    'Quadrant2': [],
    'Quadrant3': [],
    'Quadrant4': [],
  };

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  // Load tasks from shared preferences
  Future<void> _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final savedTasks = prefs.getString('tasks');
    if (savedTasks != null) {
      setState(() {
        tasks = Map<String, List<String>>.from(
          json.decode(savedTasks).map(
            (key, value) => MapEntry(key, List<String>.from(value)),
          ),
        );
      });
    }
  }

  // Save tasks to shared preferences
  Future<void> _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('tasks', json.encode(tasks));
  }

  // Add new task
  void _addTask(String category) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return TaskDialog(
          controller: controller,
          onSubmit: (task) {
            if (tasks[category]!.length < 3) {
              setState(() {
                tasks[category]!.add(task);
              });
              _saveTasks(); // Save tasks after adding
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Task limit exceeded! Max 3 tasks.")),
              );
            }
          },
          onCancel: () {
            Navigator.pop(context);
          }, onDelete: () {  },
        );
      },
    );
  }

  // Edit an existing task
  void _editTask(String category, int index) {
  final controller = TextEditingController(text: tasks[category]![index]);
  showDialog(
    context: context,
    builder: (context) {
      return TaskDialog(
        controller: controller,
        onSubmit: (task) {
          setState(() {
            tasks[category]![index] = task;
          });
        },
        onCancel: () {
          Navigator.pop(context); // Close the dialog without changes
        },
        onDelete: () {
          setState(() {
            tasks[category]!.removeAt(index); // Remove the task
          });
        },
      );
    },
  );
}


  // Handle task drop
  void _onDrop(String targetCategory, String task) {
    if (tasks[targetCategory]!.length < 3) {
      setState(() {
        // Remove the task from the previous category
        tasks.forEach((category, taskList) {
          taskList.remove(task);
        });
        // Add the task to the target category
        tasks[targetCategory]!.add(task);
      });
      _saveTasks(); // Save tasks after dropping
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Task limit exceeded! Max 3 tasks.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("The Square",style: TextStyle(fontWeight:FontWeight.bold),),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 150),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Spacer(),
                Text("Urgent", style: TextStyle(fontWeight: FontWeight.bold)),
                Spacer(flex: 2),
                Text("Not Urgent", style: TextStyle(fontWeight: FontWeight.bold)),
                Spacer(),
              ],
            ),
            const SizedBox(height: 1),
            Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    RotatedBox(
                      quarterTurns: 3,
                      child: Text("Important", style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(height: 50),
                    RotatedBox(
                      quarterTurns: 3,
                      child: Text("Not Important", style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GridView.builder(
                      itemCount: tasks.keys.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 4.0,
                        crossAxisSpacing: 4.0,
                        childAspectRatio: 1.2,
                      ),
                      itemBuilder: (context, index) {
                        final category = tasks.keys.elementAt(index);
                        return Quadrant(
                          category: category,
                          tasks: tasks[category]!,
                          onDoubleTap: () => _addTask(category),
                          onEditTask: (taskIndex) => _editTask(category, taskIndex),
                          onDropTask: (draggedTask) {
                            _onDrop(category, draggedTask);
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
