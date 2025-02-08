import 'package:flutter/material.dart';
import 'package:tisaneconnect/app/color.dart';
import 'package:tisaneconnect/app/constant.dart';
import 'package:tisaneconnect/app/font_style.dart';
import 'package:tisaneconnect/ui/components/button/primary_button.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
                  Text("Nama : XXXX"),
                  const SizedBox(height: 40),
                  Text("Role : XXXX"),
                  const SizedBox(height: 40),
                  PrimaryButton(
                      label: "Logout", radius: 100, onTap: () {
                      })
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}


