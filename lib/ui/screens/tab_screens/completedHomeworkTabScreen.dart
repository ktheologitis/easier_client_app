import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/completedHomeworkPoolBloc/completedHomeworkPoolBarrel.dart';
import '../../components/completedHomeworkTypeLayer.dart';

class CompletedHomeworkTabScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CompletedHomeworkPoolBloc completedHomeworkPoolBloc =
        BlocProvider.of<CompletedHomeworkPoolBloc>(context);

    return BlocBuilder<CompletedHomeworkPoolBloc, CompletedHomeworkPoolState>(
      builder: (_, state) {
        if (state is CompletedHomeworkPoolInit) {
          completedHomeworkPoolBloc.add(CompletedHomeworkPoolBeingFetched());
          return Center(
            child: SizedBox(
              height: 40,
              width: 40,
              child: CircularProgressIndicator(
                color: Theme.of(context).accentColor,
              ),
            ),
          );
        } else {
          return ListView.separated(
            itemCount: state.completedHomeworkPool.data.length,
            separatorBuilder: (context, index) => SizedBox(height: 8.0),
            itemBuilder: (context, index) {
              return CompletedHomeworkTypeLayer(
                  completedHomeworkTitle:
                      state.completedHomeworkPool.data.keys.toList()[index],
                  completedHomeworkTypes:
                      state.completedHomeworkPool.data.values.toList()[index]);
            },
          );
        }
      },
    );
  }
}
