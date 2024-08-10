import 'package:flutter/material.dart';
import 'package:sky_app/zerefs/zeref_base.dart';
import 'package:sky_app/zerefs/zeref_provider.dart';

extension ReadContext on BuildContext {
  T get<T extends ZerefBase>() {
    return ZerefProvider.of<T>(
      this,
    );
  }
}



