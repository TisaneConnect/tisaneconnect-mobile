import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io' show SocketException;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tisaneconnect/app/snackbar.dart';

class AuthController {
  final String baseUrl = 'http://103.139.193.137:5000';

  /// Fungsi Login
  Future<bool> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'username': username.trim(),
          'password': password.trim(),
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final String? token = responseData['token'];
        final String username = responseData['username'] ?? 'Unknown';
        final String role = responseData['role'] ?? 'Unknown';

        if (token == null || token.isEmpty) {
          print("Login gagal: Token tidak ditemukan.");
          return false;
        }

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', token);
        await prefs.setString('user_username', username);
        await prefs.setString('user_role', role);

        print("Login berhasil! Username: $username, Role: $role");
        return true;
      } else {
        print("Login gagal: ${response.body}");
        return false;
      }
    } catch (e) {
      print("Unexpected error: $e");
      return false;
    }
  }

  /// Fungsi Logout
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();

    // Debugging sebelum dihapus
    print("Before Logout - Username: ${prefs.getString('user_username')}");
    print("Before Logout - Role: ${prefs.getString('user_role')}");

    await prefs.remove('auth_token');
    await prefs.remove('user_username');
    await prefs.remove('user_role');

    // Debugging setelah dihapus
    print("After Logout - Username: ${prefs.getString('user_username')}");
    print("After Logout - Role: ${prefs.getString('user_role')}");
  }

  /// Cek apakah user masih login
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('auth_token');
  }

  /// Ambil data user dari SharedPreferences
  Future<Map<String, String?>> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'username': prefs.getString('user_username'),
      'role': prefs.getString('user_role'),
    };
  }
}
