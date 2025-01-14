import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tisaneconnect/app/color.dart';
import 'package:tisaneconnect/app/constant.dart';
import 'package:tisaneconnect/app/font_style.dart';
import 'package:tisaneconnect/app/image.dart';
import 'package:tisaneconnect/app/navigation.dart';
import 'package:tisaneconnect/ui/components/button/primary_button.dart';
import 'package:tisaneconnect/ui/components/text_field/text_field_primary.dart';
import 'package:tisaneconnect/ui/pages/admin/home/home.dart';
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  ValueNotifier<bool> isObs = ValueNotifier<bool>(false);
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
                  
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: screenHeight() * 0.1,
                    ),
                    
                    SvgPicture.asset(
                      ImageAsset.logo,
                      width: screenWidth() * 0.5
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text("Register", 
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      fontFamily: "Poppins",
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFieldPrimary(
                      keyboardType: TextInputType.text,
                      label: "Name",
                      hintText: "John Doe",
                    ),
                    
                    TextFieldPrimary(
                      keyboardType: TextInputType.emailAddress,
                      label: "Email",
                      hintText: "hello@example.com",
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    ValueListenableBuilder(
                      valueListenable: isObs,
                      builder: (context, val, _) {
                        return TextFieldPrimary(
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
                    ValueListenableBuilder(
                      valueListenable: isObs,
                      builder: (context, val, _) {
                        return TextFieldPrimary(
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
                          label: "Confirm Password",
                        );
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    PrimaryButton(
                      label: "Sign Up",
                      radius: 100,
                      onTap: () {
                        nav.goRemove(const HomeScreen());
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text.rich(
                TextSpan(
                  text: "Sudah Mempunyai Akun? ",
                  children: [
                    WidgetSpan(
                      child: GestureDetector(
                        onTap: () {
                          nav.goBack();
                        },
                        child: Text(
                          "Sign Up",
                          style: StyleAsset.normal().copyWith(
                            fontSize: 14,
                            color: ColorAssets.primary400,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                style: StyleAsset.normal().copyWith(
                  fontSize: 14,
                  color: ColorAssets.logoText,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
