import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tisaneconnect/app/color.dart';
import 'package:tisaneconnect/app/constant.dart';
import 'package:tisaneconnect/app/font_style.dart';
import 'package:tisaneconnect/app/image.dart';
import 'package:tisaneconnect/app/navigation.dart';
import 'package:tisaneconnect/app/snackbar.dart';
import 'package:tisaneconnect/ui/components/button/primary_button.dart';
import 'package:tisaneconnect/ui/components/text_field/text_field_primary.dart';
import 'package:tisaneconnect/ui/pages/home/home.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                  top: padTop() + 20,
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
                      height: 40,
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
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {
                          Snackbar.error("Fitur belum tersedia");
                          
                        },
                        child: Text(
                          "Lupa password",
                          style: StyleAsset.normal().copyWith(
                            color: ColorAssets.primary400,
                          ),
                        ),
                      ),
                    ),
                    // const SizedBox(
                    //   height: 10,
                    // ),
                    // ValueListenableBuilder(
                    //   valueListenable: isKeepSigned,
                    //   builder: (c, val, _) {
                    //     return CheckboxListTile(
                    //       value: isKeepSigned.value,
                    //       onChanged: (e) {
                    //         isKeepSigned.value = !isKeepSigned.value;
                    //       },
                    //       dense: true,
                    //       checkColor: ColorAssets.white,
                    //       activeColor: ColorAssets.primary,
                    //       contentPadding: EdgeInsets.zero,
                    //       controlAffinity: ListTileControlAffinity.leading,
                    //       title: Text(
                    //         "Biarkan saya tetap masuk",
                    //         style: StyleAsset.normal().copyWith(
                    //           color: ColorAssets.white,
                    //           fontSize: screenWidth() * 0.04,
                    //         ),
                    //       ),
                    //     );
                    //   },
                    // ),
                    const SizedBox(
                      height: 20,
                    ),
                    PrimaryButton(
                      label: "Sign In",
                      radius: 100,
                      onTap: () {
                        nav.goRemove(const HomePage());
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    PrimaryButton(
                      radius: 100,
                      widget: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            ImageAsset.google,
                            width: 30,
                            height: 30,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Continue with Google",
                            style: StyleAsset.normal().copyWith(
                              color: ColorAssets.neutrals900,
                            ),
                          ),
                        ],
                      ),
                      primary: ColorAssets.neutrals100,
                      onTap: ()  {
                        nav.goRemove(const HomePage());
                      },
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text.rich(
                TextSpan(
                  text: "Belum Mempunyai Akun? ",
                  children: [
                    WidgetSpan(
                      child: GestureDetector(
                        onTap: () {
                          Snackbar.error("Fitur belum tersedia");
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
