import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../data/models/assignedhomeworkpool.dart';
import 'package:uuid/uuid.dart';
import '../../data/models/completedhomework.dart';
import 'answerHomeworkEvent.dart';
import 'answerHomeworkState.dart';
import '../../data/dataProviders/answerHomeworkDataProvider.dart';
import '../clientcubit/clientcubit.dart';

class AnswerHomeworkBloc
    extends Bloc<AnswerHomeworkEvent, AnswerHomeworkState> {
  final String referencedAssignedHomeworkId;
  final AssignedHomeworkPool assignedHomeworkPool;
  final FirebaseFirestore firestoreInstance;
  final String therapistId;
  final ClientCubit clientCubit;

  late AnswerHomeworkDataProvider answerHomeworkDataProvider;

  AnswerHomeworkBloc({
    required this.referencedAssignedHomeworkId,
    required this.assignedHomeworkPool,
    required this.firestoreInstance,
    required this.therapistId,
    required this.clientCubit,
  }) : super(AnswerHomeworkInProgress(
            completedHomework: new CompletedHomework.createNew(
          id: Uuid().v1(),
          referencedAssignedHomeworkId: referencedAssignedHomeworkId,
          assignedHomeworkPool: assignedHomeworkPool,
          sessionNumberOfCompletion: clientCubit.state.runningSessionNumber,
        ))) {
    answerHomeworkDataProvider = new AnswerHomeworkDataProvider(
      firestoreInstance: firestoreInstance,
      therapistId: therapistId,
      clientId: clientCubit.state.id,
    );
  }

  @override
  Stream<AnswerHomeworkState> mapEventToState(
      AnswerHomeworkEvent event) async* {
    if (event is AnswerHomeworkUpdated) {
      yield AnswerHomeworkInProgress(
          completedHomework: event.completedHomework);
    } else if (event is AnswerHomeworkCanceled) {
      yield AnswerHomeworkInProgress(
          completedHomework: new CompletedHomework.createNew(
        id: event.completedHomework.id,
        referencedAssignedHomeworkId: referencedAssignedHomeworkId,
        assignedHomeworkPool: assignedHomeworkPool,
        sessionNumberOfCompletion: clientCubit.state.runningSessionNumber,
      ));
    } else if (event is AnswerHomeworkSubmitted) {
      yield AnswerHomeworkFinish(completedHomework: event.completedHomework);
    } else if (event is AnswerHomeworkReset) {
      yield AnswerHomeworkInProgress(
          completedHomework: new CompletedHomework.createNew(
        id: Uuid().v1(),
        referencedAssignedHomeworkId: referencedAssignedHomeworkId,
        assignedHomeworkPool: assignedHomeworkPool,
        sessionNumberOfCompletion: clientCubit.state.runningSessionNumber,
      ));
    }
  }
}
