import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const TaskListScreen(title: 'Task Manager'),
    );
  }
}

class Tasks {
  String name;
  bool isCompleted;

  Tasks({required this.name, this.isCompleted = false});
}

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key, required this.title});

  final String title;

  @override
  State<TaskListScreen> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<TaskListScreen> {
  List<Tasks> tasks = [];
  TextEditingController taskController = TextEditingController();

  void addTask(String taskName) {
    setState(() {
      tasks.add(Tasks(name: taskName));
      taskController.clear();
    });
  }

  void toggleCompletion(int index) {
    setState(() {
      tasks[index].isCompleted = !tasks[index].isCompleted;
    });
  }

  void delete(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: taskController,
                    decoration: const InputDecoration(
                      labelText: 'Enter Task',
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    if (taskController.text.isNotEmpty) {
                      addTask(taskController.text);
                    }
                  },
                  child: const Text('Add'),
                ),
              ],
            ),
            const SizedBox(),
            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Checkbox(
                      value: tasks[index].isCompleted,
                      onChanged: (value) {
                        toggleCompletion(index);
                      },
                    ),
                    title: Text(
                      tasks[index].name,
                      style: TextStyle(
                        decoration: tasks[index].isCompleted
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                    trailing: TextButton(
                      onPressed: () {
                        delete(index);
                      },
                      child: const Text(
                        'X',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
