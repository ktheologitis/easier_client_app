import 'package:easier_client_app/logic/snackbarCubit/snackbarCubit.dart';
import 'package:easier_client_app/ui/components/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../styles/colorsIcons.dart';
import 'tab_screens/assignedHomeworkTabScreen.dart';
import '../screens/tab_screens/completedHomeworkTabScreen.dart';
import '../components/bottomAppBar.dart';

class MyHomeworkScreen extends StatefulWidget {
  static String routeName = "/";
  @override
  _MyHomeworkScreenState createState() => _MyHomeworkScreenState();
}

class _MyHomeworkScreenState extends State<MyHomeworkScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final SnackbarCubit snackbarCubit = BlocProvider.of<SnackbarCubit>(context);

    return Scaffold(
      body: BlocListener<SnackbarCubit, SnackbarState>(
        listener: (_, state) {
          if (state.show == true) {
            ScaffoldMessenger.of(context).showSnackBar(getMyCustomSnackBar(
              message: state.message,
              messageType: state.messageType,
            ));
          }
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 24),
          child: Column(
            children: [
              SizedBox(
                height: 16,
                child: Container(
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 49,
                width: width,
                child: Material(
                  color: Colors.white,
                  child: TabBar(
                    controller: _tabController,
                    labelColor: MyColors.primary,
                    labelStyle: TextStyle(fontSize: 16, wordSpacing: 1.5),
                    indicatorColor: MyColors.primary,
                    indicatorWeight: 3.0,
                    unselectedLabelColor: Colors.grey[500],
                    tabs: [
                      Tab(
                        child: Text("ASSIGNED"),
                      ),
                      Tab(
                        child: Text("COMPLETED"),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      AssignedHomeworkTabScreen(),
                      CompletedHomeworkTabScreen(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: MyBottomAppBar(),
    );
  }
}
