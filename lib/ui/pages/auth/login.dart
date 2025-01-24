import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io' show SocketException;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tisaneconnect/app/color.dart';
import 'package:tisaneconnect/app/constant.dart';
import 'package:tisaneconnect/app/image.dart';
import 'package:tisaneconnect/app/navigation.dart';
import 'package:tisaneconnect/app/snackbar.dart';
import 'package:tisaneconnect/ui/components/button/primary_button.dart';
import 'package:tisaneconnect/ui/components/text_field/text_field_primary.dart';
import 'package:tisaneconnect/ui/pages/admin/home/home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  ValueNotifier<bool> isObs = ValueNotifier<bool>(false);
  bool _isLoading = false;

  Future<void> _login() async {
    final String username = _usernameController.text.trim();
    final String password = _passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      Snackbar.error("Please enter username and password");
      return;
    }

    setState(() {
      _isLoading = true;
    });

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

      setState(() {
        _isLoading = false;
      });

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final String token = responseData['token'];

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', token);

        nav.goRemove(const HomeScreen());
      } else {
        final Map<String, dynamic> errorData = jsonDecode(response.body);
        Snackbar.error(errorData['message'] ?? 'Login failed');
      }
    } on SocketException catch (e) {
      print('Socket Error: ${e.message}');
      setState(() {
        _isLoading = false;
      });
      Snackbar.error('Cannot connect to server. Check network.');
    } catch (e) {
      print('Unexpected Error: $e');
      setState(() {
        _isLoading = false;
      });
      Snackbar.error('Unexpected error occurred.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Scaffold(
        backgroundColor: ColorAssets.background,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  left: screenWidth() / 15,
                  right: screenWidth() / 15,
                  top: padTop() + 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: screenHeight() * 0.1,
                    ),
                    SvgPicture.asset(ImageAsset.logo,
                        width: screenWidth() * 0.5),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Login",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                    TextFieldPrimary(
                      controller: _usernameController,
                      keyboardType: TextInputType.text,
                      label: "Username",
                      hintText: "Enter your username",
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    ValueListenableBuilder(
                      valueListenable: isObs,
                      builder: (context, val, _) {
                        return TextFieldPrimary(
                          controller: _passwordController,
                          hintText: "**********",
                          isObs: !isObs.value,
                          suffixIcon: IconButton(
                            onPressed: () {
                              isObs.value = !isObs.value;
                            },
                            icon: Icon(
                              isObs.value
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: Colors.black,
                            ),
                          ),
                          keyboardType: TextInputType.text,
                          label: "Password",
                        );
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    PrimaryButton(
                      label: _isLoading ? "Logging in..." : "Sign In",
                      radius: 100,
                      onTap: _isLoading ? null : _login,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
