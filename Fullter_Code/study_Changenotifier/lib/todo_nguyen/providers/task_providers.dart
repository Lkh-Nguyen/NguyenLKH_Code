import 'package:flutter/foundation.dart';

import '../model/task.dart';

class TaskProvider extends ChangeNotifier {
  final List<Task> tasks = [
    Task(
        id: "1",
        title: "Design Logo",
        description: "Make logo for the mini project",
        isDone: false),
    Task(
        id: "2",
        title: "Make UI Design",
        description: "Make Ui design for the mini project.",
        isDone: true),
    Task(
        id: "3",
        title: "Design Backend Code",
        description: "Make Backend Code for the mini project",
        isDone: false),
    Task(
        id: "4",
        title: "Make Frontend Code",
        description: "Make Frontend Code design for the mini project.",
        isDone: true),
    Task(
        id: "5",
        title: "Make Java Code",
        description: "Make Java Code design for the mini project.",
        isDone: true),
  ];


  void checkIsDone(String idTodo) {
    // Tìm task theo id
    final taskIndex = tasks.indexWhere((task) => task.id == idTodo);
    print(taskIndex);
    // Nếu tìm thấy task
    if (taskIndex != -1) {
      // Đảo ngược trạng thái của isDone
      tasks[taskIndex].isDone = !tasks[taskIndex].isDone;

      // Gọi notifyListeners để cập nhật UI
      notifyListeners();
    }
  }

  void addNewTask(Task newTask) {
    tasks.add(newTask);
    notifyListeners();
  }

  void deleteTask(String idTodo ) {
    Task task = tasks.where((element) => element.id == idTodo).toList().elementAt(0);
    tasks.remove(task);
    notifyListeners();
  }

  Task getTaskByID(String id){
    return tasks.where((element) => element.id == id).toList().elementAt(0);
  }

  // Phương thức để lọc các task đã hoàn thành
  List<Task> getFinishedTasks() {
    return tasks.where((task) => task.isDone).toList();
  }

  // Phương thức để lọc các task chưa hoàn thành
  List<Task> getNotFinishedTasks() {
    return tasks.where((task) => !task.isDone).toList();
  }


}
