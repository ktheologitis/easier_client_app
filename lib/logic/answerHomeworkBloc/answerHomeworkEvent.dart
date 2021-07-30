import '../../data/models/completedhomework.dart';

class AnswerHomeworkEvent {
  final CompletedHomework completedHomework;
  AnswerHomeworkEvent({required this.completedHomework});
}

class AnswerHomeworkUpdated extends AnswerHomeworkEvent {
  AnswerHomeworkUpdated({required CompletedHomework completedHomework})
      : super(completedHomework: completedHomework);
}

class AnswerHomeworkSubmitted extends AnswerHomeworkEvent {
  AnswerHomeworkSubmitted({required CompletedHomework completedHomework})
      : super(completedHomework: completedHomework);
}

class AnswerHomeworkCanceled extends AnswerHomeworkEvent {
  AnswerHomeworkCanceled({required CompletedHomework completedHomework})
      : super(completedHomework: completedHomework);
}

class AnswerHomeworkReset extends AnswerHomeworkEvent {
  AnswerHomeworkReset() : super(completedHomework: CompletedHomework.empty());
}
