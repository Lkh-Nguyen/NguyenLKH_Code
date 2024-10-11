import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import 'package:study_changenotifier/todo_provider/models/task_data.dart';
import 'package:study_changenotifier/todo_provider/screens/tasks_screen.dart';

// void main() => runApp(MultiProvider(
//   providers: [
//     ChangeNotifierProvider(
//       create: (_) => TaskData(),
//     )
//   ],
//   child: MyApp(),
// ));

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TasksScreen(),
    );
  }
}
