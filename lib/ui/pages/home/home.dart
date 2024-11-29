import 'package:flutter/material.dart';
import 'package:tisaneconnect/app/color.dart';
import 'package:tisaneconnect/app/constant.dart';
import 'package:tisaneconnect/app/navigation.dart';
import 'package:tisaneconnect/ui/components/button/primary_button.dart';
import 'package:tisaneconnect/ui/pages/auth/login.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorAssets.background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                    height: screenHeight() * 0.1,
                  ),
                  PrimaryButton(
                    label: "Kembali ke Login",
                    radius: 100,
                    onTap: () {
                      nav.goRemove(const LoginScreen());
                    },
                  ),
                  ],
                ),
            ))
        ],
      )
    );
  }
}