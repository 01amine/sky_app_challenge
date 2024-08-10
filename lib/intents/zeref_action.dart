import 'package:flutter/material.dart';
import 'package:sky_app/exceptions/exception.dart';
import 'package:sky_app/intents/zeref_intent.dart';
import 'package:sky_app/zerefs/direction_zeref.dart';
import 'package:sky_app/zerefs/navigation_zeref.dart';
import 'package:sky_app/zerefs/zeref_provider.dart';

class ZerefAction extends Action<ZerefIntent> {
  final BuildContext context;
  ZerefAction(this.context);

  @override
  Object? invoke(covariant ZerefIntent intent) {
    final directionZeref = ZerefProvider.of<DirectionZeref>(context);
    directionZeref.addError("An error occurred");

    final navigate = ZerefProvider.of<NavigationZeref>(context);
    navigate.navigateTo(context, "/sky");

    throw ZerefException("Let's The Game Begin");
  }
}


class DirectionAction extends Action<DirectionIntent> {
  final BuildContext context;
  final Direction direction;
  DirectionAction(this.context, this.direction);

  @override
  Object? invoke(covariant DirectionIntent intent) {
    final directionZeref = ZerefProvider.of<DirectionZeref>(context);
    directionZeref.changeDirection(direction);
    return null;
  }
}
