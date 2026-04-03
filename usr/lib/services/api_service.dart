import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // Base URL for the external database IP (to be provided by user)
  static const String baseUrl = 'http://your-provided-ip:port'; // Replace with actual IP

  // Transaction Status API
  Future<List<Map<String, dynamic>>> getTransactionStatus({
    String? status,
    DateTime? startDate,
    DateTime? endDate,
    String? mid,
    String? tid,
    String? rrn,
    String? name,
  }) async {
    final queryParams = <String, String>{};
    if (status != null && status.isNotEmpty) queryParams['status'] = status;
    if (startDate != null) queryParams['start_date'] = startDate.toIso8601String().split('T')[0];
    if (endDate != null) queryParams['end_date'] = endDate.toIso8601String().split('T')[0];
    if (mid != null && mid.isNotEmpty) queryParams['mid'] = mid;
    if (tid != null && tid.isNotEmpty) queryParams['tid'] = tid;
    if (rrn != null && rrn.isNotEmpty) queryParams['rrn'] = rrn;
    if (name != null && name.isNotEmpty) queryParams['name'] = name;

    final uri = Uri.parse('$baseUrl/transaction-status').replace(queryParameters: queryParams);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      return data.map((e) => e as Map<String, dynamic>).toList();
    } else {
      throw Exception('Failed to load transaction status');
    }
  }

  // Clearing Status API
  Future<List<Map<String, dynamic>>> getClearingStatus({
    DateTime? startDate,
    DateTime? endDate,
    String? mid,
    String? tid,
    String? rrn,
    String? name,
  }) async {
    final queryParams = <String, String>{};
    if (startDate != null) queryParams['start_date'] = startDate.toIso8601String().split('T')[0];
    if (endDate != null) queryParams['end_date'] = endDate.toIso8601String().split('T')[0];
    if (mid != null && mid.isNotEmpty) queryParams['mid'] = mid;
    if (tid != null && tid.isNotEmpty) queryParams['tid'] = tid;
    if (rrn != null && rrn.isNotEmpty) queryParams['rrn'] = rrn;
    if (name != null && name.isNotEmpty) queryParams['name'] = name;

    final uri = Uri.parse('$baseUrl/clearing-status').replace(queryParameters: queryParams);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      return data.map((e) => e as Map<String, dynamic>).toList();
    } else {
      throw Exception('Failed to load clearing status');
    }
  }

  // PayOut Transactions Details API
  Future<List<Map<String, dynamic>>> getPayoutDetails({
    DateTime? startDate,
    DateTime? endDate,
    String? aggregatorCode,
    String? mid,
    String? terminalId,
    String? rrn,
    String? stan,
    String? authCode,
  }) async {
    final queryParams = <String, String>{};
    if (startDate != null) queryParams['start_date'] = startDate.toIso8601String().split('T')[0];
    if (endDate != null) queryParams['end_date'] = endDate.toIso8601String().split('T')[0];
    if (aggregatorCode != null && aggregatorCode.isNotEmpty) queryParams['aggregator_code'] = aggregatorCode;
    if (mid != null && mid.isNotEmpty) queryParams['mid'] = mid;
    if (terminalId != null && terminalId.isNotEmpty) queryParams['terminal_id'] = terminalId;
    if (rrn != null && rrn.isNotEmpty) queryParams['rrn'] = rrn;
    if (stan != null && stan.isNotEmpty) queryParams['stan'] = stan;
    if (authCode != null && authCode.isNotEmpty) queryParams['auth_code'] = authCode;

    final uri = Uri.parse('$baseUrl/payout-details').replace(queryParameters: queryParams);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      return data.map((e) => e as Map<String, dynamic>).toList();
    } else {
      throw Exception('Failed to load payout details');
    }
  }

  // PayOut Transactions Summary API
  Future<List<Map<String, dynamic>>> getPayoutSummary({
    DateTime? startDate,
    DateTime? endDate,
    String? aggregatorCode,
    String? mid,
    String? legalName,
    String? displayName,
  }) async {
    final queryParams = <String, String>{};
    if (startDate != null) queryParams['start_date'] = startDate.toIso8601String().split('T')[0];
    if (endDate != null) queryParams['end_date'] = endDate.toIso8601String().split('T')[0];
    if (aggregatorCode != null && aggregatorCode.isNotEmpty) queryParams['aggregator_code'] = aggregatorCode;
    if (mid != null && mid.isNotEmpty) queryParams['mid'] = mid;
    if (legalName != null && legalName.isNotEmpty) queryParams['legal_name'] = legalName;
    if (displayName != null && displayName.isNotEmpty) queryParams['display_name'] = displayName;

    final uri = Uri.parse('$baseUrl/payout-summary').replace(queryParameters: queryParams);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      return data.map((e) => e as Map<String, dynamic>).toList();
    } else {
      throw Exception('Failed to load payout summary');
    }
  }

  // Create User API (mock for now, will connect to DB later)
  Future<void> createUser({
    required String name,
    required String email,
    required String employeeCode,
    required String username,
    required String password,
  }) async {
    // Mock implementation - will be replaced with actual API call when DB is connected
    // For now, just print the data
    print('Creating user: $name, $email, $employeeCode, $username, $password');
    // TODO: Send email with username and password
  }
}