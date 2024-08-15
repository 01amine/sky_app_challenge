import 'package:flutter/material.dart';
import 'package:sky_app/zerefs/zeref_base.dart';

class ZerefProvider<T extends ZerefBase> extends StatefulWidget {
  final T value;
  final Widget? child;
  const ZerefProvider({super.key, required this.value, this.child});

  @override
  State<StatefulWidget> createState() => _ZerefProviderState<T>();

  static T of<T extends ZerefBase>(BuildContext context) {
    final provider = context.findAncestorWidgetOfExactType<ZerefProvider<T>>();
    if (provider == null) {
      throw FlutterError('ZerefProvider<$T> not found in context');
    }
    return provider.value;
  }
}

class _ZerefProviderState<T extends ZerefBase> extends State<ZerefProvider<T>> {
  @override
  Widget build(BuildContext context) {
    return widget.child ?? const SizedBox.shrink();
  }

  @override
  void dispose() {
    widget.value.dispose();
    super.dispose();
  }
}
