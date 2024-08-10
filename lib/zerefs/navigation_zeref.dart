import 'package:flutter/material.dart';
import 'package:sky_app/extentions/push_extention.dart';
import 'package:sky_app/zerefs/zeref.dart';

class NavigationZeref extends Zeref<void> {
  NavigationZeref() : super(null);

  void navigateTo(BuildContext context, String routeName) {
    dispose();
    context.pushNamed(routeName);
  }
}
