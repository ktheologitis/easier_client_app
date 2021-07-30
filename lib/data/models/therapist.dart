class Therapist {
  Therapist({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.address,
    this.phone = "",
    this.age = 0,
    this.gender = "",
    this.photoUrl = "",
  });

  final String id;
  String firstName;
  String lastName;
  String email;
  String address;
  String phone;
  int age;
  String gender;
  String photoUrl;
}
