import 'package:flutter/material.dart';

class Quadrant extends StatelessWidget {
  final List<String> tasks;
  final VoidCallback onDoubleTap;
  final void Function(int index) onEditTask;
  final void Function(String draggedTask) onDropTask;

  const Quadrant({
    super.key,
    required this.tasks,
    required this.onDoubleTap,
    required this.onEditTask,
    required this.onDropTask, required String category,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: onDoubleTap,
      child: DragTarget<String>(
        onAccept: onDropTask,
        builder: (context, candidateData, rejectedData) {
          return Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.amber, width: 2.0),
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start, // Align tasks to the top
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (int i = 0; i < tasks.length; i++)
                  Draggable<String>(
                    data: tasks[i],
                    feedback: Material(
                      color: Colors.transparent,
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Text(
                          tasks[i],
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    childWhenDragging: Opacity(
                      opacity: 0.5,
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 4.0),
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Text(
                          tasks[i],
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    child: GestureDetector(
                      onTap: () => onEditTask(i),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 4.0),
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Text(
                          tasks[i],
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                if (tasks.isEmpty)
                  Center(
                    child: const Text(
                      "No Tasks",
                      style: TextStyle(fontWeight: FontWeight.w100),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
