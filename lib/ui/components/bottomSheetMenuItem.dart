import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  MenuItem({required this.icon, required this.title, required this.onTapItem});

  final Icon icon;
  final String title;
  final void Function() onTapItem;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapItem,
      child: Container(
        height: 56,
        child: Row(
          children: [
            icon,
            SizedBox(width: 16.0),
            Text(
              title,
              style: TextStyle(
                  fontSize: Theme.of(context).textTheme.subtitle1?.fontSize),
            ),
          ],
        ),
      ),
    );
  }
}
