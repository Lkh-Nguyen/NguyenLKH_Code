import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_changenotifier/animation/transitions.dart';
import 'package:study_changenotifier/todo_nguyen/providers/task_providers.dart';
import 'package:study_changenotifier/todo_nguyen/screen/detail_todo.dart';
import 'package:study_changenotifier/todo_nguyen/theme/style_color.dart';
import 'package:study_changenotifier/todo_nguyen/widget/form_todo.dart';

import '../model/task.dart';
import '../widget/card_todo.dart';

class HomeTodo extends StatefulWidget {
  const HomeTodo({super.key});

  @override
  State<HomeTodo> createState() => _HomeTodoState();
}

class _HomeTodoState extends State<HomeTodo> {
  String filterValue = "all";
  @override
  Widget build(BuildContext context) {
    List<Task> tasks = context.watch<TaskProvider>().tasks.cast<Task>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "TO DO LIST",
          style: TextStyle(
            color: StyleColor.colorPrimary,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          GestureDetector(
              onTap: () {},
              child: Image.asset(
                "assets/images/icons/settings.png",
                width: 60,
              )),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(
                      "assets/images/icons/Union.png",
                      width: 60,
                    ),
                    const Text(
                      "LIST OF TODO",
                      style: TextStyle(
                          color: StyleColor.colorSecondary,
                          fontWeight: FontWeight.bold,
                          fontSize: 30),
                    ),
                  ],
                ),
                PopupMenuButton(
                  child: Image.asset(
                    "assets/images/icons/filter.png",
                    width: 60,
                  ),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: "all",
                      child: (filterValue == "all")
                          ? const Text(
                              "All Todo",
                              style:
                                  TextStyle(color: StyleColor.colorSecondary),
                            )
                          : const Text(
                              "All Todo",
                              style: TextStyle(color: Colors.grey),
                            ),
                    ),
                    PopupMenuItem(
                      value: "finish",
                      child: (filterValue == "finish")
                          ? const Text(
                              "Finished Todo",
                              style:
                                  TextStyle(color: StyleColor.colorSecondary),
                            )
                          : const Text(
                              "Finished Todo",
                              style: TextStyle(color: Colors.grey),
                            ),
                    ),
                    PopupMenuItem(
                      value: "not_finish",
                      child: (filterValue == "not_finish")
                          ? const Text(
                              "Not Finished Todo",
                              style:
                                  TextStyle(color: StyleColor.colorSecondary),
                            )
                          : const Text(
                              "Not Finished Todo",
                              style: TextStyle(color: Colors.grey),
                            ),
                    ),
                  ],
                  onSelected: (value) {
                    print(value);
                    setState(() {
                      if (value == "all") {
                        filterValue = "all";
                      } else if (value == "finish") {
                        filterValue = "finish";
                      } else if (value == "not_finish") {
                        filterValue = "not_finish";
                      }
                    });
                  },
                ),
              ],
            ),
            Consumer<TaskProvider>(builder: (context, value, child) {
              List<Task> filteredTasks;
              // Lọc các task dựa trên filterValue
              if (filterValue == "finish") {
                filteredTasks = value.getFinishedTasks().cast<Task>();
              } else if (filterValue == "not_finish") {
                filteredTasks = value.getNotFinishedTasks().cast<Task>();
              } else {
                filteredTasks = value.tasks.cast<Task>();
              }

              return Expanded(
                child: ListView.builder(
                    itemCount: filteredTasks.length,
                    itemBuilder: (context, index) {
                      if (!filteredTasks.elementAt(index).isDone) {
                        return GestureDetector(
                          onTap: (){
                            Navigator.push(context, createSlideTransitions(newPage: DetailTodo(idTodo: filteredTasks.elementAt(index).id),));
                          },
                          child: CardTodo(
                              tasks: filteredTasks,
                              index: index,
                              colorText: StyleColor.colorWhiteTwo,
                              colorBackground: StyleColor.colorSecondary,
                              idTodo: filteredTasks.elementAt(index).id),
                        );
                      } else {
                        return GestureDetector(
                          onTap: (){
                            Navigator.push(context, createSlideTransitions(newPage: DetailTodo(idTodo : filteredTasks.elementAt(index).id),));
                          },
                          child: CardTodo(
                              tasks: filteredTasks,
                              index: index,
                              colorText: StyleColor.colorWhiteOne,
                              colorBackground: StyleColor.colorPrimary,
                              idTodo: filteredTasks.elementAt(index).id),
                        );
                      }
                    }),
              );
            }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Xử lý sự kiện khi bấm vào FloatingActionButton
          showModalBottomSheet(
            isScrollControlled: true, // Cho phép điều khiển chiều cao
            context: context,
            builder: (_) {
              return Container(
                height: 600,// Tính chiều cao full đến AppBar
                decoration: const BoxDecoration(
                    color: StyleColor.colorPrimary,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    )),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: FormTodo(task: null,),
                ),
              );
            },
          );
        },
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Image.asset("assets/images/icons/plus-circle.png"),
      ),
    );
  }
}
