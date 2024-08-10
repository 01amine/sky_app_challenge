import 'package:flutter/material.dart';
import 'package:sky_app/extentions/context_extention.dart';
import 'package:sky_app/zerefs/zeref_base.dart';

class ZerefBuilder<T extends ZerefBase> extends StatelessWidget {
  final Widget Function(BuildContext context, T value) builder;
  const ZerefBuilder({Key? key, required this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    T value = context.get<T>();
    
    return StreamBuilder<T>(
      stream:  null ,
      builder: (context, snapshot) {
        return builder(context, value);
      },
    );
  }
}
