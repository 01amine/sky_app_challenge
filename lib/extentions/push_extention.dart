import 'package:flutter/material.dart';

extension Push on BuildContext {
  void pushNamed(String routeName) {
    Navigator.of(this).pushNamed(
      routeName,
    );
  }
}
