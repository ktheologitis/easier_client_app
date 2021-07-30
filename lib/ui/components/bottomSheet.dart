import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../screens/myHomeworkScreen.dart';
import '../screens/myTherapistScreen.dart';
import 'bottomSheetMenuItem.dart';
import '../../logic/clientcubit/clientcubit.dart';
import '../../logic/therapistcubit/therapistcubit.dart';

void pushNewRoute(BuildContext context, String routeName) {
  Navigator.of(context).pop();
  if (routeName == MyTherapistScreen.routeName) {
    Navigator.of(context).pushNamedAndRemoveUntil(
      routeName,
      ModalRoute.withName('/'),
      arguments: MyTherapistScreenArguments(
        clientCubit: BlocProvider.of<ClientCubit>(context),
        therapistCubit: BlocProvider.of<TherapistCubit>(context),
      ),
    );
    return;
  }
  Navigator.of(context)
      .pushNamedAndRemoveUntil(routeName, ModalRoute.withName('/'));
}

Future<void> showMenuBottomSheet(BuildContext context) async {
  final width = MediaQuery.of(context).size.width;

  final TherapistCubit therapistCubit =
      BlocProvider.of<TherapistCubit>(context);
  final ClientCubit clientCubit = BlocProvider.of<ClientCubit>(context);

  return await showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          width: width,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MenuItem(
                  icon: Icon(Icons.rate_review),
                  title: "My Homework",
                  onTapItem: () =>
                      pushNewRoute(context, MyHomeworkScreen.routeName),
                ),
                MenuItem(
                  icon: Icon(Icons.person),
                  title: "My Therapist",
                  onTapItem: () =>
                      pushNewRoute(context, MyTherapistScreen.routeName),
                ),
                MenuItem(
                  icon: Icon(Icons.lock),
                  title: "Access Code",
                  onTapItem: () {
                    print("My Homework");
                  },
                ),
              ],
            ),
          ),
        );
      });
}
