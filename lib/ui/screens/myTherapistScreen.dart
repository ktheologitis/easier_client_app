import 'package:easier_client_app/data/models/client.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../components/bottomAppBar.dart';
import '../../logic/clientcubit/clientcubit.dart';
import '../../logic/therapistcubit/therapistcubit.dart';

class MyTherapistScreenArguments {
  final TherapistCubit therapistCubit;
  final ClientCubit clientCubit;

  MyTherapistScreenArguments({
    required this.clientCubit,
    required this.therapistCubit,
  });
}

class MyTherapistScreen extends StatelessWidget {
  static String routeName = "MyTherapistScreen";

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final statusBarHeight = MediaQuery.of(context).padding.top;

    final MyTherapistScreenArguments args = ModalRoute.of(context)!
        .settings
        .arguments as MyTherapistScreenArguments;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            height: statusBarHeight,
          ),
          Expanded(
            child: Container(
              // color: Colors.red,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: height * 0.05,
                    child: Container(
                        // color: Colors.red,
                        ),
                  ),
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black45,
                        border: Border.all(color: Colors.white, width: 2.0),
                        image: DecorationImage(
                            image: AssetImage(
                                "assets/images/therapist_photo.jpg"))),
                  ),
                  SizedBox(
                    height: height * 0.05,
                    child: Container(
                        // color: Colors.red,
                        ),
                  ),
                  Column(
                    children: [
                      Text(
                        "${args.therapistCubit.state.firstName} ${args.therapistCubit.state.lastName}",
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Container(
                        // color: Colors.amber,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.perm_phone_msg,
                              color: Colors.black87,
                            ),
                            SizedBox(
                              width: 24.0,
                            ),
                            Text(
                              "${args.therapistCubit.state.phone}",
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          // color: Colors.amber,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            // mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Colors.black87,
                              ),
                              SizedBox(
                                width: 24.0,
                              ),
                              Flexible(
                                child: Text(
                                  "${args.therapistCubit.state.address}",
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.1,
                    child: Container(
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Next Session",
                    style: TextStyle(
                      fontSize: 28,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    "Saturday, May 29, 2021 00:02",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: MyBottomAppBar(),
    );
  }
}
