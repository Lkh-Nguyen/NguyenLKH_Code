import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_provider/screen/home_todo.dart';

import 'providers/task_providers.dart';

void main() => runApp(MultiProvider(
  providers: [
    ChangeNotifierProvider(
      create: (_) => TaskProvider(),
    )
  ],
  child: MyApp(),
));

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