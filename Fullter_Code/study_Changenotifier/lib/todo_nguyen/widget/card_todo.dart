import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../model/task.dart';
import '../providers/task_providers.dart';

class CardTodo extends StatefulWidget {
  final List<Task> tasks;
  final int index;
  final Color colorText;
  final Color colorBackground;
  final String idTodo;
  const CardTodo(
      {super.key,
      required this.tasks,
      required this.index,
      required this.colorText,
      required this.colorBackground,
        required this.idTodo,
      });

  @override
  State<CardTodo> createState() => _CardTodoState();
}

class _CardTodoState extends State<CardTodo> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 160,
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        width: double.infinity,
        decoration: BoxDecoration(
          color: widget.colorBackground,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.tasks.elementAt(widget.index).title,
                        style: TextStyle(
                          color: widget.colorText,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Checkbox(
                        hoverColor: Colors.black,
                        checkColor: Colors.black,
                        activeColor: Colors.white,
                        value: widget.tasks.elementAt(widget.index).isDone,
                        onChanged: (bool? value) {
                          // Hàm thay đổi trạng thái
                          setState(() {
                            context
                                .read<TaskProvider>()
                                .checkIsDone(widget.idTodo);
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.tasks.elementAt(widget.index).description,
                    style:  TextStyle(
                      overflow: TextOverflow.ellipsis,
                      color: widget.colorText,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              Text(
                "Create at ${DateFormat('EEEE, d MMMM yyyy').format(widget.tasks.elementAt(widget.index).createAtDate)}",
                style:  TextStyle(
                  color: widget.colorText,
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
