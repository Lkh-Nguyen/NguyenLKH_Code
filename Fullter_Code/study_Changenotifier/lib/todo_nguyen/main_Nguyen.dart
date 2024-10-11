import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_changenotifier/todo_nguyen/providers/task_providers.dart';
import 'package:study_changenotifier/todo_nguyen/screen/home_todo.dart';


import 'package:study_changenotifier/todo_provider/screens/tasks_screen.dart';
//
// void main() => runApp(MultiProvider(
//   providers: [
//     ChangeNotifierProvider(
//       create: (_) => TaskProvider(),
//     )
//   ],
//   child: MyApp(),
// ));

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeTodo(),
    );
  }
}
