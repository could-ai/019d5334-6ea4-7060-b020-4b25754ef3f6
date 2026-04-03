import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  User? _currentUser;

  User? get currentUser => _currentUser;

  // Mock login - replace with actual authentication
  Future<bool> login(String username, String password) async {
    // Mock users for demo
    if (username == 'admin' && password == 'admin') {
      _currentUser = User(
        id: 1,
        name: 'Admin User',
        email: 'admin@example.com',
        employeeCode: 'ADM001',
        username: 'admin',
        password: 'admin',
        isAdmin: true,
      );
      notifyListeners();
      return true;
    } else if (username == 'child' && password == 'child') {
      _currentUser = User(
        id: 2,
        name: 'Child User',
        email: 'child@example.com',
        employeeCode: 'CHL001',
        username: 'child',
        password: 'child',
        isAdmin: false,
      );
      notifyListeners();
      return true;
    }
    return false;
  }

  void logout() {
    _currentUser = null;
    notifyListeners();
  }
}

class User {
  final int id;
  final String name;
  final String email;
  final String employeeCode;
  final String username;
  final String password;
  final bool isAdmin;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.employeeCode,
    required this.username,
    required this.password,
    required this.isAdmin,
  });
}