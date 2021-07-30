import 'assignedhomeworkpool.dart';

class CompletedHomework {
  late String id;
  late String referencedAssignedHomeworkId;
  late int sessionNumberOfCompletion;

  late String title;
  late List<dynamic> fields;
  late Map<dynamic, dynamic> answers;
  late DateTime dateTimeAnswered;

  CompletedHomework.createNew({
    required this.id,
    required this.referencedAssignedHomeworkId,
    required AssignedHomeworkPool assignedHomeworkPool,
    required this.sessionNumberOfCompletion,
  }) {
    title = assignedHomeworkPool.data[referencedAssignedHomeworkId]!.title;
    fields = assignedHomeworkPool.data[referencedAssignedHomeworkId]!.fields;
    answers = {};
    fields.forEach((field) {
      answers[field] = "";
    });
  }

  CompletedHomework({
    required this.id,
    required this.referencedAssignedHomeworkId,
    required this.title,
    required this.fields,
    required this.answers,
    required this.sessionNumberOfCompletion,
    required this.dateTimeAnswered,
  });

  CompletedHomework.empty();

  static CompletedHomework cloneOf(CompletedHomework completedHomework,
      {required DateTime dateTime}) {
    return new CompletedHomework(
      id: completedHomework.id,
      referencedAssignedHomeworkId:
          completedHomework.referencedAssignedHomeworkId,
      title: completedHomework.title,
      fields: completedHomework.fields,
      answers: completedHomework.answers,
      sessionNumberOfCompletion: completedHomework.sessionNumberOfCompletion,
      dateTimeAnswered: dateTime,
    );
  }
}
