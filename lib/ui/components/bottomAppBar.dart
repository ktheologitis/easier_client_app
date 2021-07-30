import 'package:flutter/material.dart';

import '../styles/colorsIcons.dart';
import 'bottomSheet.dart';

class MyBottomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: BottomAppBar(
        shape: CircularNotchedRectangle(),
        color: MyColors.primary,
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Row(children: [
            Text(
              "Easier",
              style: TextStyle(color: MyColors.lightTextIcon, fontSize: 20),
            ),
            Spacer(),
            IconButton(
              color: MyColors.lightTextIcon,
              onPressed: () {
                showMenuBottomSheet(context);
              },
              icon: Icon(Icons.more_vert),
            )
          ]),
        ),
      ),
    );
  }
}
