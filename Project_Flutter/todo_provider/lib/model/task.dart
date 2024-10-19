class Task {
  late String id;
  late String title;
  late String description;
  late DateTime createAtDate;
  late DateTime timeDateLine;
  late bool isDone;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.isDone,
    DateTime? createAtDate, // Cho phép null để kiểm tra
    DateTime? timeDateLine,
  })  : createAtDate = createAtDate ?? DateTime.now(), // Gán giá trị mặc định nếu null
        timeDateLine = timeDateLine ?? DateTime.now(); // Gán giá trị mặc định cho timeDateLine nếu null
}