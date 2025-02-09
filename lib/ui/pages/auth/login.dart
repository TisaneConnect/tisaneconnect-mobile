import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tisaneconnect/app/color.dart';
import 'package:tisaneconnect/app/constant.dart';
import 'package:tisaneconnect/app/image.dart';
import 'package:tisaneconnect/app/navigation.dart';
import 'package:tisaneconnect/app/snackbar.dart';
import 'package:tisaneconnect/domain/auth/auth_controller.dart';
import 'package:tisaneconnect/template.dart';
import 'package:tisaneconnect/ui/components/button/primary_button.dart';
import 'package:tisaneconnect/ui/components/text_field/text_field_primary.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthController _loginController = AuthController();

  ValueNotifier<bool> isObs = ValueNotifier<bool>(false);
  bool _isLoading = false;

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });

    final String username = _usernameController.text.trim();
    final String password = _passwordController.text.trim();

    final bool success = await _loginController.login(username, password);

    if (success) {
      print("Login berhasil, pindah halaman...");
      nav.goRemove(const Template());
    } else {
      print("Login gagal, tetap di halaman login.");
      Snackbar.error('Login failed. Please check your credentials.');
    }

    setState(() {
      _isLoading = false;
    });
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
