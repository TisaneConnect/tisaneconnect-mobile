import 'package:flutter/material.dart';
import 'package:tisaneconnect/app/constant.dart';
import 'package:tisaneconnect/app/font_style.dart';

class TextFieldPrimary extends StatelessWidget {
  const TextFieldPrimary({
    Key? key,
    this.controller,
    this.label,
    this.isObs = false,
    this.readOnly = false,
    this.hintText,
    this.isRaw = false,
    this.keyboardType,
    this.suffixIcon,
    this.maxLength,
    this.maxLines = 1,
    this.onTap,
    this.stroke = Colors.black,
    this.color = Colors.black,
    this.onSubmit,
    this.radius = 8,
    this.textInputAction,
    this.onChanged,
  }) : super(key: key);
  final TextEditingController? controller;
  final String? label, hintText;
  final TextInputType? keyboardType;
  final double radius;
  final Widget? suffixIcon;
  final int? maxLength, maxLines;
  final Color stroke, color;
  final bool isRaw, isObs, readOnly;
  final TextInputAction? textInputAction;
  final Function()? onTap;
  final Function(String)? onChanged, onSubmit;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if (!isRaw)
          Text(
            label ?? "",
            style: StyleAsset.normal().copyWith(
              fontSize: screenWidth() / 28,
              color: color,
            ),
            textAlign: TextAlign.center,
          ),
        if (!isRaw) yHeight(1),
        TextFormField(
          key: key,
          textInputAction: textInputAction,
          onChanged: onChanged,
          maxLength: maxLength,
          onTap: onTap,
          maxLines: maxLines,
          onFieldSubmitted: onSubmit,
          readOnly: readOnly,
          obscureText: isObs,
          keyboardType: keyboardType,
          controller: controller,
          validator: (e) {
            if (e != null) {
              if (e.isEmpty) {
                return "This field is required";
              }
            }
            return null;
          },
          style: StyleAsset.normal().copyWith(
            color: color,
            fontSize: 13,
          ),
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            hintStyle: StyleAsset.normal().copyWith(
              color: color.withOpacity(0.4),
              fontSize: 13,
            ),
            contentPadding: const EdgeInsets.all(15),
            isDense: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius),
              borderSide: BorderSide(
                color: stroke,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius),
              borderSide: BorderSide(
                color: stroke,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius),
              borderSide: BorderSide(
                color: stroke,
              ),
            ),
            hintText: hintText,
          ),
        ),
        if (!isRaw) yHeight(2),
      ],
    );
  }
}
