import 'package:easier_client_app/ui/screens/existingHomeworkFieldAnswerScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/completedhomework.dart';
import '../../logic/completedHomeworkPoolBloc/completedHomeworkPoolBarrel.dart';
import 'package:easier_client_app/ui/styles/colorsIcons.dart';

class SingleAnswerPreviewBox extends StatelessWidget {
  final String completedHomeworkField;
  final String completedHomeworkAnswer;
  final CompletedHomework completeDHomework;
  final ScrollController _scrollController = ScrollController();

  SingleAnswerPreviewBox({
    required this.completedHomeworkField,
    required this.completedHomeworkAnswer,
    required this.completeDHomework,
  });
  @override
  Widget build(BuildContext context) {
    final CompletedHomeworkPoolBloc completedHomeworkPoolBloc =
        BlocProvider.of<CompletedHomeworkPoolBloc>(context);

    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: 100,
        maxHeight: 150,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: MyColors.lightTextIcon,
          borderRadius: BorderRadius.all(
            Radius.circular(15.0),
          ),
          border: Border.all(color: Colors.black, width: 1),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            top: 8.0,
            bottom: 16.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    completedHomeworkField,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 18,
                    ),
                  ),
                  Spacer(),
                  Material(
                    color: Colors.transparent,
                    child: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                            ExistingHomeworkFieldAnswerScreen.routeName,
                            arguments:
                                ExistingHomeworkFieldAnswerScreenArguments(
                              fieldName: completedHomeworkField,
                              completedHomework: completeDHomework,
                              completedHomeworkPoolBloc:
                                  completedHomeworkPoolBloc,
                            ));
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              Flexible(
                child: Scrollbar(
                  thickness: 4,
                  interactive: true,
                  controller: _scrollController,
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: Text(
                      completedHomeworkAnswer,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.clip,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
