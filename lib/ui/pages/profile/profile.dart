import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import SharedPreferences
import 'package:tisaneconnect/app/color.dart';
import 'package:tisaneconnect/app/constant.dart';
import 'package:tisaneconnect/app/font_style.dart';
import 'package:tisaneconnect/ui/components/button/primary_button.dart';
import 'package:tisaneconnect/ui/pages/auth/login.dart';
import 'package:tisaneconnect/domain/auth/auth_controller.dart';
import 'package:tisaneconnect/app/navigation.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final AuthController _authController = AuthController();
  String _username = 'Loading...'; // Default value
  String _role = 'Loading...'; // Default value

  @override
  void initState() {
    super.initState();
    _loadUserData(); // Panggil fungsi untuk mengambil data pengguna
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();

    // Debugging - Cek apakah data benar-benar ada di SharedPreferences
    print("Stored Username: ${prefs.getString('user_username')}");
    print("Stored Role: ${prefs.getString('user_role')}");

    setState(() {
      _username = prefs.getString('user_username') ?? 'N/A';
      _role = prefs.getString('user_role') ?? 'N/A';
    });
  }

  Future<void> _logout() async {
    await _authController.logout(); // Tunggu hingga logout selesai
    nav.goRemove(const LoginScreen()); // Pindah ke halaman login
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Scaffold(
        backgroundColor: ColorAssets.background,
        body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                left: screenWidth() / 10,
                right: screenWidth() / 10,
                top: padTop() + 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: screenHeight() * 0.1,
                  ),
                  Text(
                    "Profile",
                    style: StyleAsset.bold(fontSize: 30),
                  ),
                  const SizedBox(height: 40),
                  Text("Nama : $_username"), // Tampilkan nama
                  const SizedBox(height: 40),
                  Text("Role : $_role"), // Tampilkan role
                  const SizedBox(height: 40),
                  PrimaryButton(
                    label: "Logout",
                    radius: 100,
                    onTap: _logout,
                  )
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
