import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io' show SocketException;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tisaneconnect/app/navigation.dart';
import 'package:tisaneconnect/app/snackbar.dart';
import 'package:tisaneconnect/ui/pages/admin/home/home.dart';

class AuthController {
  Future<bool> login(String username, String password) async {
    if (username.isEmpty || password.isEmpty) {
      Snackbar.error("Please enter username and password");
      return false;
    }

    try {
      final response = await http.post(
        Uri.parse('http://192.168.0.105:5000/login'), // Change this
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

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', token);

        nav.goRemove(const HomeScreen());
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
}
