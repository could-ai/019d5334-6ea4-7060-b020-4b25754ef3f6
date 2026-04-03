import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogProvider with ChangeNotifier {
  List<String> _logs = [];

  List<String> get logs => _logs;

  Future<void> loadLogs() async {
    final prefs = await SharedPreferences.getInstance();
    _logs = prefs.getStringList('activity_logs') ?? [];
    notifyListeners();
  }

  Future<void> addLog(String activity) async {
    final timestamp = DateTime.now().toIso8601String();
    final logEntry = '[$timestamp] ${activity}';
    _logs.add(logEntry);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('activity_logs', _logs);
    notifyListeners();
  }

  Future<void> clearLogs() async {
    _logs.clear();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('activity_logs');
    notifyListeners();
  }
}