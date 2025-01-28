import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io' show SocketException;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tisaneconnect/app/navigation.dart';
import 'package:tisaneconnect/app/snackbar.dart';
import 'package:tisaneconnect/ui/pages/admin/home/home.dart';
import 'package:tisaneconnect/ui/pages/superadmin/homesuperadmin.dart';

class AuthController {
  final String baseUrl = 'http://103.139.193.137:5000';
  Future<bool> login(String username, String password) async {
    if (username.isEmpty || password.isEmpty) {
      Snackbar.error("Please enter username and password");
      return false;
    }

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final String token = responseData['token'];

        // Decode the JWT token to get the role
        final decodedToken = parseJwt(token);
        final String role = decodedToken['role'] ?? '';

        // Save token and role to SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', token);
        await prefs.setString('user_role', role);

        // Navigate based on role
        if (role == 'superadmin') {
          nav.goRemove(HomeSuperAdmin());
        } else if (role == 'admin') {
          nav.goRemove(const HomeScreen());
        } else {
          Snackbar.error('Invalid user role');
          return false;
        }

        return true;
      } else {
        final Map<String, dynamic> errorData = jsonDecode(response.body);
        Snackbar.error(errorData['message'] ?? 'Login failed');
        return false;
      }
    } on SocketException catch (e) {
      print('Socket Error: ${e.message}');
      Snackbar.error('Cannot connect to server. Check network.');
      return false;
    } catch (e) {
      print('Unexpected Error: $e');
      Snackbar.error('Unexpected error occurred.');
      return false;
    }
  }

  // Helper method to decode JWT token
  Map<String, dynamic> parseJwt(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      return {};
    }

    final payload = parts[1];
    final normalized = base64Url.normalize(payload);
    final resp = utf8.decode(base64Url.decode(normalized));
    final payloadMap = json.decode(resp);
    return payloadMap;
  }
}
