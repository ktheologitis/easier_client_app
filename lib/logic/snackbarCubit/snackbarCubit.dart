import 'package:bloc/bloc.dart';

enum MessageType {
  information,
  error,
}

class SnackbarState {
  final bool show;
  final String message;
  final MessageType messageType;

  SnackbarState({
    this.show = false,
    this.message = "",
    this.messageType = MessageType.information,
  });
}

class SnackbarCubit extends Cubit<SnackbarState> {
  SnackbarCubit() : super(SnackbarState());

  void showSnackbar(
      {required String message, required MessageType messageType}) {
    emit(SnackbarState(
      show: true,
      message: message,
      messageType: messageType,
    ));
    emit(SnackbarState(
      show: false,
      message: message,
      messageType: messageType,
    ));
  }
}
