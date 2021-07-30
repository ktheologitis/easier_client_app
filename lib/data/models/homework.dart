import 'package:cloud_firestore/cloud_firestore.dart';

class Homework {
  final String id;
  String title;
  List<dynamic> fields;
  final DateTime? dateCreated;

  Homework({
    required this.id,
    this.title = "",
    this.fields = const [],
    this.dateCreated,
  });

  Map<String, dynamic> toFirestoreJson() => {
        "id": id,
        "title": title,
        "fields": fields,
        "dateCreated": dateCreated != null
            ? Timestamp.fromDate(dateCreated!)
            : Timestamp.fromDate(DateTime.now()),
      };
}
