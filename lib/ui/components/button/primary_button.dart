import 'package:flutter/material.dart';
import 'package:tisaneconnect/app/color.dart';
import 'package:tisaneconnect/app/constant.dart';
import 'package:tisaneconnect/app/font_style.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    Key? key,
    this.width = 100,
    this.height = 48,
    this.radius = 0,
    this.label,
    this.onTap,
    this.isLoading = false,
    this.primary,
    this.widget,
    this.style,
  }) : super(key: key);
  final double? width, height;
  final double radius;
  final Function()? onTap;
  final String? label;
  final Color? primary;
  final Widget? widget;
  final TextStyle? style;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width != null ? (screenWidth() / 100 * width!) : width,
      child: ElevatedButton(
        onPressed: isLoading ? null : onTap,
        style: ElevatedButton.styleFrom(
          disabledBackgroundColor: ColorAssets.primary200,
          backgroundColor: primary ?? ColorAssets.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
        child: isLoading
            ? const CircularProgressIndicator()
            : widget ??
                Text(
                  label ?? '',
                  style: style ??
                      StyleAsset.normal().copyWith(
                        color: Colors.white,
                        fontSize: screenWidth() / 25,
                      ),
                ),
      ),
    );
  }
}
