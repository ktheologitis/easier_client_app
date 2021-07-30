import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../data/models/completedhomeworkpool.dart';
import '../../data/repositories/completedHomeworkPoolRepository.dart';
import './completedHomeworkPoolEvent.dart';
import './completedHomeworkPoolState.dart';
import '../../data/models/completedhomework.dart';
import '../answerHomeworkBloc/answerHomeworkEvent.dart';
import '../snackbarCubit/snackbarCubit.dart';

class CompletedHomeworkPoolBloc
    extends Bloc<CompletedHomeworkPoolEvent, CompletedHomeworkPoolState> {
  final FirebaseFirestore firestoreInstance;
  final String therapistId;
  final String clientId;
  final SnackbarCubit snackbarCubit;

  late CompletedHomeworkPoolRepository completedHomeworkPoolRepository;

  CompletedHomeworkPoolBloc({
    required this.firestoreInstance,
    required this.therapistId,
    required this.clientId,
    required this.snackbarCubit,
  }) : super(CompletedHomeworkPoolInit(
            completedHomeworkPool: CompletedHomeworkPool())) {
    completedHomeworkPoolRepository = CompletedHomeworkPoolRepository(
      firestoreInstance: firestoreInstance,
      clientId: clientId,
      therapistId: therapistId,
    );
  }

  @override
  Stream<CompletedHomeworkPoolState> mapEventToState(
      CompletedHomeworkPoolEvent event) async* {
    if (event is CompletedHomeworkSubmitted) {
      yield* _mapCompletedHomeworkSubmittedEventToState(event);
    } else if (event is CompletedHomeworkUpdated) {
      yield* _mapCompletedHomeworkUpdatedEventToState(event);
    } else if (event is CompletedHomeworkPoolBeingFetched) {
      yield* _mapCompletedHomeworkPoolBeingFetchedEventToState(event);
    } else if (event is CompletedHomeworkDeleted) {
      yield* _mapCompletedHomeworkDeletedEventToState(event);
    }
  }

  Stream<CompletedHomeworkPoolState> _mapCompletedHomeworkDeletedEventToState(
      CompletedHomeworkDeleted event) async* {
    try {
      completedHomeworkPoolRepository.deleteCompletedHomework(
          completedHomeworkId: event.completedHomework.id);
      state
          .completedHomeworkPool
          .data[event.completedHomework.title]![
              event.completedHomework.sessionNumberOfCompletion]!
          .remove(event.completedHomework.id);

      if (state
          .completedHomeworkPool
          .data[event.completedHomework.title]![
              event.completedHomework.sessionNumberOfCompletion]!
          .isEmpty) {
        state.completedHomeworkPool.data[event.completedHomework.title]!
            .remove(event.completedHomework.sessionNumberOfCompletion);
      }

      if (state
          .completedHomeworkPool.data[event.completedHomework.title]!.isEmpty) {
        state.completedHomeworkPool.data.remove(event.completedHomework.title);
      }

      yield CompletedHomeworkPoolSyncedWithDatabase(
          completedHomeworkPool: state.completedHomeworkPool);
    } catch (err) {
      snackbarCubit.showSnackbar(
        message: "Error deleting homework",
        messageType: MessageType.error,
      );
      yield CompletedHomeworkPoolSyncedWithDatabase(
          completedHomeworkPool: state.completedHomeworkPool);
    }
  }

  Stream<CompletedHomeworkPoolState>
      _mapCompletedHomeworkPoolBeingFetchedEventToState(
          CompletedHomeworkPoolBeingFetched event) async* {
    try {
      final CompletedHomeworkPool completedHomeworkPool =
          await completedHomeworkPoolRepository.getCompletedHomeworkPool();
      yield CompletedHomeworkPoolSyncedWithDatabase(
          completedHomeworkPool: completedHomeworkPool);
    } catch (err) {
      print(err);
      snackbarCubit.showSnackbar(
        message: "Error fetching completed homework from cloud",
        messageType: MessageType.error,
      );
      yield CompletedHomeworkPoolSyncedWithDatabase(
          completedHomeworkPool: state.completedHomeworkPool);
    }
  }

  Stream<CompletedHomeworkPoolState> _mapCompletedHomeworkSubmittedEventToState(
      CompletedHomeworkSubmitted event) async* {
    try {
      await completedHomeworkPoolRepository.submitCompletedHomework(
          completedHomework: event.completedHomework);
      if (state is CompletedHomeworkPoolInit) {
        yield CompletedHomeworkPoolInit(
            completedHomeworkPool: state.completedHomeworkPool);
      } else if (state is CompletedHomeworkPoolSyncedWithDatabase) {
        state.completedHomeworkPool.data.update(
          event.completedHomework.title,
          (value) => {
            ...value,
            event.completedHomework.sessionNumberOfCompletion: value.update(
              event.completedHomework.sessionNumberOfCompletion,
              (value) => {
                ...value,
                event.completedHomework.id: event.completedHomework
              },
              ifAbsent: () =>
                  {event.completedHomework.id: event.completedHomework},
            )
          },
          ifAbsent: () => {
            event.completedHomework.sessionNumberOfCompletion: {
              event.completedHomework.id: event.completedHomework
            }
          },
        );
        yield CompletedHomeworkPoolSyncedWithDatabase(
            completedHomeworkPool: state.completedHomeworkPool);
      }
      event.answerHomeworkBloc.add(AnswerHomeworkReset());
      snackbarCubit.showSnackbar(
        message: "Successfully shared completed homework with your therapist!",
        messageType: MessageType.information,
      );
    } catch (err) {
      snackbarCubit.showSnackbar(
        message: "Error submitting your new completed homework",
        messageType: MessageType.error,
      );
      event.answerHomeworkBloc.add(
          AnswerHomeworkCanceled(completedHomework: event.completedHomework));
      yield CompletedHomeworkPoolInit(
          completedHomeworkPool: state.completedHomeworkPool);
    }
  }

  Stream<CompletedHomeworkPoolState> _mapCompletedHomeworkUpdatedEventToState(
      CompletedHomeworkUpdated event) async* {
    try {
      Map<String, String> updatedAnswers =
          formatUpdatedAnswersForFirestoreNestedMapField(
              event.completedHomework);
      completedHomeworkPoolRepository.updateCompleteHomework(
        completedHomeworkId: event.completedHomework.id,
        updatedAnswers: updatedAnswers,
      );
      state.completedHomeworkPool.data.update(
        event.completedHomework.title,
        (value) => {
          ...value,
          event.completedHomework.sessionNumberOfCompletion: value.update(
            event.completedHomework.sessionNumberOfCompletion,
            (value) =>
                {...value, event.completedHomework.id: event.completedHomework},
            ifAbsent: () =>
                {event.completedHomework.id: event.completedHomework},
          )
        },
        ifAbsent: () => {
          event.completedHomework.sessionNumberOfCompletion: {
            event.completedHomework.id: event.completedHomework
          }
        },
      );
      yield CompletedHomeworkPoolSyncedWithDatabase(
          completedHomeworkPool: state.completedHomeworkPool);
      snackbarCubit.showSnackbar(
        message: "Successfully updated answer",
        messageType: MessageType.information,
      );
    } catch (err) {
      snackbarCubit.showSnackbar(
        message: "Error updating answer",
        messageType: MessageType.error,
      );
      yield CompletedHomeworkPoolSyncedWithDatabase(
          completedHomeworkPool: state.completedHomeworkPool);
    }
  }

  Map<String, String> formatUpdatedAnswersForFirestoreNestedMapField(
      CompletedHomework updatedCompletedHomework) {
    Map<String, String> updatedAnswers = {};
    updatedCompletedHomework.answers.forEach((key, value) {
      updatedAnswers["answers." + key] = value;
    });
    return updatedAnswers;
  }
}
