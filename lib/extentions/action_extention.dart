import 'package:flutter/material.dart';

extension MyAction on BuildContext {
  void invokeAction<T extends Intent>(T intent) {
    Actions.invoke(this, intent);
  }
}