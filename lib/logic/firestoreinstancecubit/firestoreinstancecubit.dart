import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreInstanceCubit extends Cubit<FirebaseFirestore> {
  FirestoreInstanceCubit() : super(FirebaseFirestore.instance);
}
