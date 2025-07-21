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
      ),
      home: const ToDoHomePage(),
    );
  }
}

class ToDoHomePage extends StatefulWidget {
  const ToDoHomePage({super.key});

  @override
  State<ToDoHomePage> createState() => _ToDoHomePageState();
}

class _ToDoHomePageState extends State<ToDoHomePage> {
  final List<String> _tasks = [];
  void addTask(String task) {
    setState(() {
      _tasks.add(task);
    });
  }

  void updateTask(int index, String newTask) {
    setState(() {
      _tasks[index] = newTask;
    });
  }

  void deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  void showAddTaskDialog() {
    final TextEditingController _taskController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('add new task'),
          content: TextField(
            controller: _taskController,
            decoration: InputDecoration(hintText: 'Enter Task name'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_taskController.text.isNotEmpty) {
                  addTask(_taskController.text);
                }
                Navigator.of(context).pop();
              },
              child: Text('add'),
            ),
          ],
        );
      },
    );
  }

  void showUpdateTaskDialog(int index) {
    final TextEditingController _taskController = TextEditingController(
      text: _tasks[index],
    );
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('update task'),
          content: TextField(
            controller: _taskController,
            decoration: InputDecoration(hintText: 'Edit task Name'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_taskController.text.isNotEmpty) {
                  updateTask(index, _taskController.text);
                }
                Navigator.of(context).pop();
              },
              child: Text('update'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('To-Do-APP')),
      body: ListView.builder(
        itemCount: _tasks.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(_tasks[index]),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              deleteTask(index);
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('task deleted')));
            },
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 20.0),
              child: Icon(Icons.delete, color: Colors.white),
            ),
            child: ListTile(
              title: Text(_tasks[index]),
              onTap: () => showUpdateTaskDialog(index),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showAddTaskDialog,
        child: Icon(Icons.add),
      ),
    );
  }
}
