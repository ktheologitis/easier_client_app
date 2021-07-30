import 'homeworkpool.dart';
import 'homework.dart';

class AssignedHomework {
  final String id;
  final String referencedHomeworkId; // id of the object inside the homeworkpool
  String note = "";
  late String title;
  late List<dynamic> fields;

  AssignedHomework.fromCloud({
    required this.id,
    required this.referencedHomeworkId,
    required this.note,
    required HomeworkPool homeworkPool,
  }) {
    title = homeworkPool.data[referencedHomeworkId]!.title;
    fields = homeworkPool.data[referencedHomeworkId]!.fields;
  }

  AssignedHomework({
    required this.id,
    required this.referencedHomeworkId,
    required this.note,
    required Homework homework,
  }) {
    title = homework.title;
    fields = homework.fields;
  }
}
