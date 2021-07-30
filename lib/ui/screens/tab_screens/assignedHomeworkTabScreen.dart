import 'package:easier_client_app/logic/answerHomeworkBloc/answerHomeworkBarrel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/clientcubit/clientcubit.dart';
import '../../../logic/therapistcubit/therapistcubit.dart';
import '../../../logic/firestoreinstancecubit/firestoreinstancecubit.dart';
import '../../components/assignedHomeworkListItem.dart';
import '../../../logic/assignedhomeworkpoolbloc/assignedhomeworkpoolbarrel.dart';
import '../../../logic/snackbarCubit/snackbarCubit.dart';
import '../../components/snackbar.dart';

class AssignedHomeworkTabScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AssignedHomeworkPoolBloc assignedHomeworkPoolBloc =
        BlocProvider.of<AssignedHomeworkPoolBloc>(context);
    final clientCubit = BlocProvider.of<ClientCubit>(context);
    final therapistId = BlocProvider.of<TherapistCubit>(context).state.id;
    final firestoreInstance =
        BlocProvider.of<FirestoreInstanceCubit>(context).state;

    return BlocBuilder<AssignedHomeworkPoolBloc, AssignedHomeworkPoolState>(
      builder: (context, state) {
        if (state is AssignedHomeworkPoolDataSyncedWithDatabase &&
            state.assignedHomeworkPool.data.isNotEmpty) {
          return ListView.separated(
            itemCount: state.assignedHomeworkPool.data.length,
            separatorBuilder: (context, index) => SizedBox(height: 16.0),
            itemBuilder: (context, index) => BlocProvider<AnswerHomeworkBloc>(
              create: (context) => AnswerHomeworkBloc(
                referencedAssignedHomeworkId:
                    state.assignedHomeworkPool.data.values.toList()[index].id,
                assignedHomeworkPool: state.assignedHomeworkPool,
                firestoreInstance: firestoreInstance,
                therapistId: therapistId,
                clientCubit: clientCubit,
              ),
              child: AssignedHomeworkListItem(
                  assignedHomeworkPool: state.assignedHomeworkPool,
                  assignedHomework:
                      state.assignedHomeworkPool.data.values.toList()[index]),
            ),
          );
        } else if (state is AssignedHomeworkPoolDataSyncedWithDatabase &&
            state.assignedHomeworkPool.data.isEmpty) {
          return Center(
            child: Text(
              "You do not have any assigned homework yet",
              style: Theme.of(context).textTheme.headline6,
            ),
          );
        } else {
          assignedHomeworkPoolBloc.add(AssignedHomeworkPoolBeingFetched());
          return Center(
            child: SizedBox(
              height: 40,
              width: 40,
              child: CircularProgressIndicator(
                color: Theme.of(context).accentColor,
              ),
            ),
          );
        }
      },
    );
  }
}
