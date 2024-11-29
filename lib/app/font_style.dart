import 'package:flutter/material.dart';

class StyleAsset {
  static TextStyle normal() {
    return const TextStyle(
      fontStyle: FontStyle.normal,
    );
  }

  static TextStyle italic() {
    return const TextStyle(
      fontStyle: FontStyle.italic,
    );
  }

  static TextStyle bold() {
    return const TextStyle(
      fontWeight: FontWeight.bold,
    );
  }
}
