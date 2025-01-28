import 'package:flutter/material.dart';
import 'package:tisaneconnect/app/color.dart';
import 'package:tisaneconnect/app/navigation.dart';

class Snackbar {
  static general(String? label, [BuildContext? context]) {
    return ScaffoldMessenger.of(context ?? nav.nk.currentContext!).showSnackBar(
      SnackBar(
        content: Text(
          label ?? "",
        ),
      ),
    );
  }

  static error(String? label, [BuildContext? context]) {
    return ScaffoldMessenger.of(context ?? nav.nk.currentContext!).showSnackBar(
      SnackBar(
        backgroundColor: ColorAssets.error,
        content: Text(
          label ?? "",
        ),
      ),
    );
  }

  static success(String? label, [BuildContext? context]) {
    return ScaffoldMessenger.of(context ?? nav.nk.currentContext!).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        content: Text(
          label ?? "",
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  static info(String? label, [BuildContext? context]) {
    return ScaffoldMessenger.of(context ?? nav.nk.currentContext!).showSnackBar(
      SnackBar(
        backgroundColor: Colors.blue,
        content: Text(
          label ?? "",
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  static warning(String? label, [BuildContext? context]) {
    return ScaffoldMessenger.of(context ?? nav.nk.currentContext!).showSnackBar(
      SnackBar(
        backgroundColor: Colors.orange,
        content: Text(
          label ?? "",
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
