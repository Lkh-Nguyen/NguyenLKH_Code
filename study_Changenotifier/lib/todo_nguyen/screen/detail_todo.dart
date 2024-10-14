import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:study_changenotifier/todo_nguyen/model/task.dart';
import 'package:study_changenotifier/todo_nguyen/providers/task_providers.dart';
import 'package:study_changenotifier/todo_nguyen/screen/home_todo.dart';
import 'package:study_changenotifier/todo_nguyen/theme/style_color.dart';
import 'package:study_changenotifier/todo_nguyen/widget/form_todo.dart';
import 'package:study_changenotifier/todo_nguyen/widget/show_scaffold_messenger.dart';

class DetailTodo extends StatefulWidget {
  const DetailTodo({super.key, required this.idTodo});
  final String idTodo;
  @override
  State<DetailTodo> createState() => _DetailTodoState();
}

class _DetailTodoState extends State<DetailTodo> {
  @override
  Widget build(BuildContext context) {
    Task task = context.read<TaskProvider>().getTaskByID(widget.idTodo);
    return Scaffold(
      appBar: builderAppBarDetailTo(context, task),
      body:  Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  style: const TextStyle(
                      color: StyleColor.colorBlack,
                      fontSize: 26,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                task.description,
                  style: const TextStyle(
                    color: StyleColor.colorBlack,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
          ),
           Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Create at ${DateFormat('EEEE, d MMMM yyyy').format(task.createAtDate)}",
                  style: const TextStyle(
                    color: StyleColor.colorBlack,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }


  AppBar builderAppBarDetailTo(BuildContext context, Task task){
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back),
      ),
      actions: [

        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.access_time),
        ),


        IconButton(
          onPressed: () {
            showModalBottomSheet(
              isScrollControlled: true, // Cho phép điều khiển chiều cao
              context: context,
              builder: (BuildContext context) {
                return Container(
                  height: 600, // Tính chiều cao full đến AppBar
                  decoration: const BoxDecoration(
                      color: StyleColor.colorPrimary,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                      )),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    child: FormTodo(task: task,),
                  ),
                );
              },
            );
          },
          icon: const Icon(Icons.edit_outlined),
        ),


        IconButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Transform.translate(
                    offset: const Offset(0,30),
                    child: Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: SizedBox(
                        height: 50,
                        child: GestureDetector(
                          onTap: () {
                            context.read<TaskProvider>().deleteTask(widget.idTodo);
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => HomeTodo()),
                                  (route) => false,
                            );
                            ShowScaffoldMessenger.showScaffoldMessengerSuccessfully(context,  "Delete ToDo Successfully!");
                          },
                          child: const Center(
                              child: Text(
                                "Delete Todo",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 16
                                ),
                              )),
                        ),
                      ),
                    ),
                  ),
                  Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: SizedBox(
                      height: 50,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          ShowScaffoldMessenger.showScaffoldMessengerSuccessfully(context,  "Cancel DeleteS ToDo Successfully!");
                        },
                        child: const Center(
                            child: Text(
                              "Cancel Todo",
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 16
                              ),
                            )),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            );
          },
          icon: const Icon(Icons.delete_outline_outlined),
        ),
      ],
    );
  }
}
