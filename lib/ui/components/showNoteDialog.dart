import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> showNoteDialog({
  required BuildContext context,
  required String homeworkTitle,
  required String note,
}) async {
  return await showDialog(
      context: context,
      builder: (_) {
        final height = MediaQuery.of(context).size.height;
        final width = MediaQuery.of(context).size.width;

        return AlertDialog(
          contentPadding: const EdgeInsets.all(16.0),
          title: Text("$homeworkTitle - Therapist's note"),
          content: Text(note),
          actions: [
            SizedBox(
              height: 36,
              width: 100,
              child: ElevatedButton(
                  child: Text("CLOSE"),
                  onPressed: () => Navigator.of(context).pop()),
            ),
          ],
        );
      });
}
