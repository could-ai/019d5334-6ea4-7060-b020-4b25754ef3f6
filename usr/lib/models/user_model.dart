class User {
  final int? id;
  final String name;
  final String email;
  final String employeeCode;
  final String username;
  final String password;
  final bool isAdmin;

  User({
    this.id,
    required this.name,
    required this.email,
    required this.employeeCode,
    required this.username,
    required this.password,
    this.isAdmin = false,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      employeeCode: json['employee_code'],
      username: json['username'],
      password: json['password'],
      isAdmin: json['is_admin'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'employee_code': employeeCode,
      'username': username,
      'password': password,
      'is_admin': isAdmin,
    };
  }
}