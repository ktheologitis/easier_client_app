import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/completedhomework.dart';
import '../../logic/completedHomeworkPoolBloc/completedHomeworkPoolBarrel.dart';
import '../components/bottomAppBar.dart';
import '../components/singleAnswerPreviewBox.dart';

class ReviewExistingCompletedHomeworkScreenArguments {
  final String homeworkDateTimeTitle;
  final CompletedHomework completedHomework;
  final CompletedHomeworkPoolBloc completedHomeworkPoolBloc;

  ReviewExistingCompletedHomeworkScreenArguments({
    required this.homeworkDateTimeTitle,
    required this.completedHomework,
    required this.completedHomeworkPoolBloc,
  });
}

class ReviewExistingCompletedHomeworkScreen extends StatelessWidget {
  static String routeName = "ReviewExistingCompletedHomeworkScreen";

  final ScrollController _scrollcontroller = ScrollController();

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final width = MediaQuery.of(context).size.width;
    var args = ModalRoute.of(context)!.settings.arguments
        as ReviewExistingCompletedHomeworkScreenArguments;

    return BlocProvider<CompletedHomeworkPoolBloc>.value(
      value: args.completedHomeworkPoolBloc,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            SizedBox(
              height: statusBarHeight,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 16.0, right: 16.0, top: 16.0, bottom: 0),
              child: Container(
                // color: Colors.amber,
                child: SizedBox(
                  height: 56,
                  width: width,
                  child: Row(
                    children: [
                      SizedBox(
                        height: 48,
                        width: 48,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.rate_review_outlined,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 24.0,
                      ),
                      Text(
                        args.homeworkDateTimeTitle,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Spacer(),
                      IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Divider(
              indent: 90,
              endIndent: 16,
              thickness: 1,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 16.0, right: 16.0, top: 0, bottom: 16.0),
                child: Container(
                  // color: Colors.red,
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    removeBottom: true,
                    child: Scrollbar(
                      thickness: 5,
                      controller: _scrollcontroller,
                      child: ListView.separated(
                        controller: _scrollcontroller,
                        itemCount: args.completedHomework.fields.length,
                        separatorBuilder: (_, index) => SizedBox(
                          height: 8,
                        ),
                        itemBuilder: (_, index) {
                          final currentField =
                              args.completedHomework.fields.toList()[index];
                          return SingleAnswerPreviewBox(
                            completedHomeworkField: currentField,
                            completedHomeworkAnswer:
                                args.completedHomework.answers[currentField],
                            completeDHomework: args.completedHomework,
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: MyBottomAppBar(),
      ),
    );
  }
}
