class UserData {
  String uid;
  String username;
  String email;
  String password;
  String dob;
  String lastname;
  String firstname;

  UserData(
      {required this.uid,
      required this.username,
      required this.email,
      required this.password,
      required this.dob,
      required this.lastname,
      required this.firstname});

  @override
  String toString() {
    return 'UserData{uid: $uid, username: $username, email: $email, dob: $dob, lastname: $lastname, firstname: $firstname}';
  }

  String get fullName {
    return "$firstname $lastname";
  }
}
class Credential {
  final String email;
  final String password;

  const Credential({required this.email, required this.password});

  @override
  String toString() => 'Credential{email: $email, password: $password}';
}