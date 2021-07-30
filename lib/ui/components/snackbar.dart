import 'package:flutter/material.dart';

import '../../logic/snackbarCubit/snackbarCubit.dart';
import '../styles/colorsIcons.dart';

SnackBar getMyCustomSnackBar(
    {required String message, required MessageType messageType}) {
  return SnackBar(
    content: Text(
      message,
      style: TextStyle(
        fontWeight: FontWeight.bold,
      ),
    ),
    backgroundColor: messageType == MessageType.error
        ? MyColors.alertColor
        : MyColors.secondary,
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.all(16.0),
  );
}
