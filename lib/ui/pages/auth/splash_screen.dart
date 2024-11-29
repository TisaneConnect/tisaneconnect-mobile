import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tisaneconnect/app/color.dart';
import 'package:tisaneconnect/app/constant.dart';
import 'package:tisaneconnect/app/image.dart';
import 'package:tisaneconnect/app/navigation.dart';
import 'package:tisaneconnect/ui/pages/auth/login.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

 @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Future.delayed(const Duration(seconds: 2));
      nav.goRemove(const LoginScreen());
    });
  } 
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorAssets.background,
      body: SizedBox(
        width: screenWidth(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedSize(
              curve: Curves.ease,
              alignment: Alignment.topCenter,
              duration: const Duration(
                seconds: 1
            ),
            child: SvgPicture.asset(
              ImageAsset.logo,
              width: screenWidth() *0.5,
            ),
            ),
          ],
        ),
      ),
    );
  }
}