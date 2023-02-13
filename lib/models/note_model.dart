import 'package:hive/hive.dart';

part 'note_model.g.dart';

@HiveType(typeId: 0)
class NoteModel extends HiveObject {
  @HiveField(0)
  String? title;
  @HiveField(1)
  String? content;
  @HiveField(2)
  DateTime? dateTime;

  NoteModel({this.title, this.content, this.dateTime});

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      title: json['title'],
      content: json['content'],
      dateTime: json['dateTime'],
    );
  }
  Map<String, dynamic> toJson() => {
        'title': title,
        'content': content,
        'dateTime': dateTime,
      };
}
