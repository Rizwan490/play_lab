class SignUpModel {
  final String? refer;
  final String email;
  final bool? agree;
  final String firstName;
  final String lastName;
  final String password;

  SignUpModel({
    this.refer,
    required this.email,
    required this.agree,
    required this.lastName,
    required this.firstName,
    required this.password,
  });
}
