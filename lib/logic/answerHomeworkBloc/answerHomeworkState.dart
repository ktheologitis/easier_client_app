import '../../data/models/completedhomework.dart';

class AnswerHomeworkState {
  final CompletedHomework completedHomework;
  AnswerHomeworkState({required this.completedHomework});
}

class AnswerHomeworkInProgress extends AnswerHomeworkState {
  AnswerHomeworkInProgress({required CompletedHomework completedHomework})
      : super(completedHomework: completedHomework);
}

class AnswerHomeworkFinish extends AnswerHomeworkState {
  AnswerHomeworkFinish({required CompletedHomework completedHomework})
      : super(completedHomework: completedHomework);
}
