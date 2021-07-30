import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './ui/styles/theme.dart';
import 'ui/screens/myHomeworkScreen.dart';
import 'ui/screens/myTherapistScreen.dart';
import './ui/screens/previewHomeworkFieldsScreen.dart';
import './logic/therapistcubit/therapistcubit.dart';
import './logic/clientcubit/clientcubit.dart';
import './logic/firestoreinstancecubit/firestoreinstancecubit.dart';
import './logic/assignedhomeworkpoolbloc/assignedhomeworkpoolbarrel.dart';
import './logic/completedHomeworkPoolBloc/completedHomeworkPoolBarrel.dart';
import 'ui/screens/fieldAnswerScreen.dart';
import './logic/snackbarCubit/snackbarCubit.dart';
import './ui/screens/reviewExistingCompletedHomeworkScreen.dart';
import './ui/screens/existingHomeworkFieldAnswerScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
              child: Text(
            "Error",
            textDirection: TextDirection.ltr,
          ));
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => FirestoreInstanceCubit()),
              BlocProvider(create: (_) => TherapistCubit()),
              BlocProvider(create: (_) => ClientCubit()),
              BlocProvider(create: (_) => SnackbarCubit()),
              BlocProvider(
                create: (context) => AssignedHomeworkPoolBloc(
                  clientCubit: BlocProvider.of<ClientCubit>(context),
                  therapistCubit: BlocProvider.of<TherapistCubit>(context),
                  firestoreInstanceCubit:
                      BlocProvider.of<FirestoreInstanceCubit>(context),
                  snackbarCubit: BlocProvider.of<SnackbarCubit>(context),
                ),
              ),
              BlocProvider(
                create: (context) => CompletedHomeworkPoolBloc(
                    firestoreInstance:
                        BlocProvider.of<FirestoreInstanceCubit>(context).state,
                    therapistId:
                        BlocProvider.of<TherapistCubit>(context).state.id,
                    clientId: BlocProvider.of<ClientCubit>(context).state.id,
                    snackbarCubit: BlocProvider.of<SnackbarCubit>(context)),
              ),
            ],
            child: MaterialApp(
              title: 'Flutter Demo',
              theme: getTheme(),
              initialRoute: MyHomeworkScreen.routeName,
              routes: {
                MyHomeworkScreen.routeName: (context) => MyHomeworkScreen(),
                MyTherapistScreen.routeName: (context) => MyTherapistScreen(),
                PreviewHomeworkFieldsScreen.routeName: (context) =>
                    PreviewHomeworkFieldsScreen(),
                FieldAnswerScreen.routeName: (context) => FieldAnswerScreen(),
                ReviewExistingCompletedHomeworkScreen.routeName: (context) =>
                    ReviewExistingCompletedHomeworkScreen(),
                ExistingHomeworkFieldAnswerScreen.routeName: (context) =>
                    ExistingHomeworkFieldAnswerScreen(),
              },
            ),
          );
        }

        return CircularProgressIndicator();
      },
    );
  }
}
