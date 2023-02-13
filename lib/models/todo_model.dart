import 'package:hive/hive.dart';

part 'todo_model.g.dart';

@HiveType(typeId: 1)
class TodoModel extends HiveObject {
  @HiveField(0)
  String? taskTitle;
  @HiveField(1)
  bool? isChecked;
  TodoModel({this.taskTitle, this.isChecked = false});
  factory TodoModel.fromJson(Map<dynamic, dynamic> json) {
    return TodoModel(
      taskTitle: json['taskTitle'],
      isChecked: json['isChecked'],
    );
  }
  Map<dynamic, dynamic> toJson() => {
        'taskTitle': taskTitle,
        'isChecked': isChecked,
      };
}
