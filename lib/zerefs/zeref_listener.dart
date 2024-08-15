// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:sky_app/zerefs/zeref.dart';
import 'package:sky_app/zerefs/zeref_builder.dart';
import 'package:sky_app/zerefs/zeref_provider.dart';

class ZerefListener<T extends Zeref> extends StatelessWidget {
  final void Function(BuildContext context, T value) listener;
  final Widget child;
  const ZerefListener({super.key, required this.listener, required this.child});
  @override
  Widget build(BuildContext context) {
    T value = ZerefProvider.of<T>(context);
    return ZerefBuilder<T>(
      builder: (context, value) {
        listener(context, value);
        return child;
      },
    );
  }
}
