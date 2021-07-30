import '../../data/models/completedhomework.dart';
import '../answerHomeworkBloc/answerHomeworkBloc.dart';

class CompletedHomeworkPoolEvent {}

class CompletedHomeworkPoolBeingFetched extends CompletedHomeworkPoolEvent {
  CompletedHomeworkPoolBeingFetched();
}

class CompletedHomeworkSubmitted extends CompletedHomeworkPoolEvent {
  final CompletedHomework completedHomework;
  final AnswerHomeworkBloc answerHomeworkBloc;
  CompletedHomeworkSubmitted({
    required this.completedHomework,
    required this.answerHomeworkBloc,
  });
}

class CompletedHomeworkUpdated extends CompletedHomeworkPoolEvent {
  final CompletedHomework completedHomework;
  CompletedHomeworkUpdated({required this.completedHomework});
}

class CompletedHomeworkDeleted extends CompletedHomeworkPoolEvent {
  final CompletedHomework completedHomework;
  CompletedHomeworkDeleted({required this.completedHomework});
}
