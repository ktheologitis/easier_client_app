import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './assignedhomeworkpoolbarrel.dart';
import '../clientcubit/clientcubit.dart';
import '../therapistcubit/therapistcubit.dart';
import '../firestoreinstancecubit/firestoreinstancecubit.dart';
import '../../data/repositories/assignedhomeworkpoolRepository.dart';
import '../../data/models/assignedhomeworkpool.dart';
import '../../logic/snackbarCubit/snackbarCubit.dart';

class AssignedHomeworkPoolBloc
    extends Bloc<AssignedHomeworkPoolEvent, AssignedHomeworkPoolState> {
  final ClientCubit clientCubit;
  final TherapistCubit therapistCubit;
  final FirestoreInstanceCubit firestoreInstanceCubit;
  final SnackbarCubit snackbarCubit;

  late AssignedHomeworkPoolRepository assignedHomeworkPoolRepository;

  AssignedHomeworkPoolBloc({
    required this.clientCubit,
    required this.therapistCubit,
    required this.firestoreInstanceCubit,
    required this.snackbarCubit,
  }) : super(AssignedHomeworkPoolInit(
            assignedHomeworkPool: AssignedHomeworkPool())) {
    assignedHomeworkPoolRepository = AssignedHomeworkPoolRepository(
      clientId: clientCubit.state.id,
      therapistId: therapistCubit.state.id,
      firestoreInstance: firestoreInstanceCubit.state,
    );
  }

  @override
  Stream<AssignedHomeworkPoolState> mapEventToState(
      AssignedHomeworkPoolEvent event) async* {
    if (event is AssignedHomeworkPoolBeingFetched) {
      yield* _mapAssignedHomeworkPoolBeingFetched(event);
    }
  }

  Stream<AssignedHomeworkPoolState> _mapAssignedHomeworkPoolBeingFetched(
      AssignedHomeworkPoolBeingFetched event) async* {
    try {
      AssignedHomeworkPool assignedHomeworkPool =
          await assignedHomeworkPoolRepository.getAssignedHomework();
      yield AssignedHomeworkPoolDataSyncedWithDatabase(
          assignedHomeworkPool: assignedHomeworkPool);
    } catch (err) {
      snackbarCubit.showSnackbar(
        message: "Error fetching your assigned homework.",
        messageType: MessageType.error,
      );
    }
  }
}
