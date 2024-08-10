import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sky_app/intents/zeref_intent.dart';
import 'package:sky_app/presentation/home.dart';
import 'package:sky_app/presentation/sky.dart';
import 'package:sky_app/zerefs/direction_zeref.dart';
import 'package:sky_app/zerefs/navigation_zeref.dart';
import 'package:sky_app/zerefs/zeref_provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ZerefProvider<DirectionZeref>(
      value: DirectionZeref(),
      child: ZerefProvider<NavigationZeref>(
        value: NavigationZeref(),
        child: MaterialApp(
          home: Shortcuts(
            shortcuts: {
              LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyG,
                  LogicalKeyboardKey.keyD): const ZerefIntent(),
            },
            child: const Home(),
          ),
          routes: {
            '/sky': (_) => const Sky(),
          },
        ),
      ),
    );
  }
}
