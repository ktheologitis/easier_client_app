import 'package:cloud_firestore/cloud_firestore.dart';

class Client {
  Client({
    required this.id,
    this.firstName = "",
    this.lastName = "",
    this.phone = "",
    this.presentingProblem = "",
    this.gender = "",
    this.address = "",
    this.email = "",
    this.referencedBy = "",
    this.age = 0,
    this.emergencyContactFirstName = "",
    this.emergencyContactLastName = "",
    this.emergencyContactPhoneNumber = "",
    this.emergencyContactRelationToClient = "",
    this.nextSession,
    this.runningSessionNumber = 0,
    this.active = true,
  });

  final String id;
  String firstName;
  String lastName;
  String phone;
  String email;
  String address;
  int age;
  String gender;
  String presentingProblem;
  String referencedBy;
  String emergencyContactFirstName;
  String emergencyContactLastName;
  String emergencyContactPhoneNumber;
  String emergencyContactRelationToClient;
  DateTime? nextSession;
  int runningSessionNumber;
  bool active;

  static Client cloneOf(Client client) {
    return new Client(
      id: client.id,
      firstName: client.firstName,
      lastName: client.lastName,
      phone: client.phone,
      email: client.email,
      address: client.address,
      age: client.age,
      gender: client.gender,
      presentingProblem: client.presentingProblem,
      referencedBy: client.referencedBy,
      emergencyContactFirstName: client.emergencyContactFirstName,
      emergencyContactLastName: client.emergencyContactLastName,
      emergencyContactPhoneNumber: client.emergencyContactPhoneNumber,
      emergencyContactRelationToClient: client.emergencyContactRelationToClient,
      nextSession: client.nextSession,
      runningSessionNumber: client.runningSessionNumber,
      active: client.active,
    );
  }

  Map<String, dynamic> toFirestoreJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "phone": phone,
        "email": email,
        "address": address,
        "age": age,
        "gender": gender,
        "presentingProblem": presentingProblem,
        "referencedBy": referencedBy,
        "emergencyContact.firstName": emergencyContactFirstName,
        "emergencyContact.lastName": emergencyContactLastName,
        "emergencyContact.phone": emergencyContactPhoneNumber,
        "emergencyContact.relation": emergencyContactRelationToClient,
        "nextSession": Timestamp.fromDate(nextSession!),
        "runningSessionNumber": runningSessionNumber,
        "active": active,
      };
}
