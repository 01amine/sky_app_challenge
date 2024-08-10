import 'package:flutter/material.dart';
import 'package:sky_app/action_dispatchers/logging_action.dart';
import 'package:sky_app/intents/zeref_action.dart';
import 'package:sky_app/intents/zeref_intent.dart';
import 'package:sky_app/platform/platform.dart';
import 'package:sky_app/zerefs/navigation_zeref.dart';
import 'package:sky_app/zerefs/zeref_provider.dart';

class Home extends StatelessWidget {
  const Home({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Actions(
      dispatcher: LoggingActionDispatcher(),
      actions: {ZerefIntent: ZerefAction(context)},
      child: Builder(builder: (context) {
        return Focus(
          autofocus: true,
          child: GestureDetector(
            onVerticalDragDown: (details) {
              if (getCurrentPlatform() == PlatformType.mobile) {
                final navigationZeref =
                    ZerefProvider.of<NavigationZeref>(context);
                // Navigate to the sky
                navigationZeref.navigateTo(context, '/sky');
              }
            },
            child: Scaffold(
                body: Center(
              child: getCurrentPlatform() == PlatformType.mobile
                  ? const Text('Swipe down to navigate to sky')
                  : const Text('Click the right shortcut to navigate to sky'),
            )),
          ),
        );
      }),
    );
  }
}
