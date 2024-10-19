import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/task.dart';
import '../providers/task_providers.dart';
import '../theme/style_color.dart';


class FormTodo extends StatefulWidget {
  final Task? task;
  FormTodo({super.key, required this.task});

  @override
  State<FormTodo> createState() => _FormTodoState();
}

class _FormTodoState extends State<FormTodo> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController _dateLineController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Khởi tạo controller với giá trị từ task nếu có
    titleController = TextEditingController(text: widget.task?.title ?? '');
    descriptionController =
        TextEditingController(text: widget.task?.description ?? '');
    _dateLineController =
        TextEditingController(text: widget.task?.timeDateLine.toString() ?? '');
  }

  @override
  Widget build(BuildContext context) {
    if ((widget.task != null)) {
      print('1');
      return Form(
        key: _formKey,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 130),
              child: Divider(
                color: Colors.white,
                thickness: 5,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: titleController,
              keyboardType: TextInputType.text,
              cursorColor: Colors.white,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                label: const Text("Title task"),
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: StyleColor.colorWhiteOne,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                      color: Colors.white,
                      width: 3 // Màu border khi không được chọn
                      ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                      color: Colors.white, width: 3 // Màu border khi được chọn
                      ),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please input information";
                }
                return null;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              maxLines: 10,
              controller: descriptionController,
              keyboardType: TextInputType.text,
              cursorColor: Colors.white,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                label: const Text("Description task"),
                labelStyle: const TextStyle(
                    color: StyleColor.colorWhiteOne,
                    fontWeight: FontWeight.bold),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                      color: Colors.white,
                      width: 3 // Màu border khi không được chọn
                      ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                      color: Colors.white, width: 3 // Màu border khi được chọn
                      ),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please input information";
                }
                return null;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _dateLineController,
              keyboardType: TextInputType.text,
              cursorColor: Colors.white,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                label: const Text("Deadline Time"),
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: StyleColor.colorWhiteOne,
                ),
                suffixIcon: const Icon(
                  Icons.calendar_month,
                  color: Colors.white,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                      color: Colors.white, // Màu border khi không được chọn
                      width: 3),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                      color: Colors.white, // Màu border khi được chọn
                      width: 3),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                  style: TextButton.styleFrom(
                      backgroundColor: StyleColor.colorWhiteTwo,
                      foregroundColor: StyleColor.colorPrimary),
                  onPressed: () {},
                  child: const Text(
                    "ADD TODO",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                  )),
            ),
          ],
        ),
      );
    } else {
      print('2');
      return Form(
        key: _formKey,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 130),
              child: Divider(
                color: Colors.white,
                thickness: 5,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: titleController,
              keyboardType: TextInputType.text,
              cursorColor: Colors.white,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                label: const Text("Title task"),
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: StyleColor.colorWhiteOne,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                      color: Colors.white,
                      width: 3 // Màu border khi không được chọn
                      ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                      color: Colors.white, width: 3 // Màu border khi được chọn
                      ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              maxLines: 10,
              controller: descriptionController,
              keyboardType: TextInputType.text,
              cursorColor: Colors.white,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                label: const Text("Description task"),
                labelStyle: const TextStyle(
                    color: StyleColor.colorWhiteOne,
                    fontWeight: FontWeight.bold),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                      color: Colors.white,
                      width: 3 // Màu border khi không được chọn
                      ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                      color: Colors.white, width: 3 // Màu border khi được chọn
                      ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _dateLineController,
              keyboardType: TextInputType.text,
              cursorColor: Colors.white,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                label: const Text("Deadline Time"),
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: StyleColor.colorWhiteOne,
                ),
                suffixIcon: const Icon(
                  Icons.calendar_month,
                  color: Colors.white,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                      color: Colors.white, // Màu border khi không được chọn
                      width: 3),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                      color: Colors.white, // Màu border khi được chọn
                      width: 3),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                  style: TextButton.styleFrom(
                      backgroundColor: StyleColor.colorWhiteTwo,
                      foregroundColor: StyleColor.colorPrimary),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Task newTask = Task(
                          id: "8",
                          title: titleController.text,
                          description: descriptionController.text,
                          isDone: false);
                      context.read<TaskProvider>().addNewTask(newTask);
                      Navigator.pop(context);
                    }
                  },
                  child: const Text(
                    "ADD TODO",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                  )),
            ),
          ],
        ),
      );
    }
  }
}
