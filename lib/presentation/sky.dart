import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sky_app/intents/zeref_action.dart';
import 'package:sky_app/intents/zeref_intent.dart';
import 'package:sky_app/presentation/widgets/shooting_stars.dart';
import 'package:sky_app/presentation/widgets/space_background.dart';
import 'dart:math' as math;

import 'package:sky_app/zerefs/direction_zeref.dart';
import 'package:sky_app/zerefs/zeref_builder.dart';
import 'package:sky_app/zerefs/zeref_provider.dart';

class Sky extends StatefulWidget {
  const Sky({super.key});

  @override
  State<Sky> createState() => _SkyState();
}

class _SkyState extends State<Sky> with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _controller2;
  late List<Animation<double>> animations;
  @override
  void initState() {
    _controller = AnimationController(
        vsync: this,
        duration: const Duration(
          seconds: 25,
        ));
    _controller2 = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 25,
      ),
    );
    animations = List.generate(
        2,
        (index) => Tween<double>(begin: 0.0, end: 2).animate(
              CurvedAnimation(
                parent: index == 0 ? _controller : _controller2,
                curve: const Interval(
                  0,
                  1,
                  curve: Curves.linear,
                ),
              ),
            ));
    super.initState();
  }

  void init() {
    _controller.reset();
    _controller2.reset();
    _controller.repeat();
    _controller2.repeat();
  }

  List<int> dy = List.generate(300, (index) => math.Random().nextInt(5000));

  @override
  Widget build(BuildContext context) {
    List<int> dx1 = List.generate(300, (index) => math.Random().nextInt(1000));
    List<int> dx2 = List.generate(300, (index) => math.Random().nextInt(1100));

    return Shortcuts(
      shortcuts: {
        // Define shortcuts here
        LogicalKeySet(LogicalKeyboardKey.arrowUp): const DirectionIntentUp(),
        LogicalKeySet(LogicalKeyboardKey.arrowDown):
            const DirectionIntentDown(),
        LogicalKeySet(LogicalKeyboardKey.arrowLeft):
            const DirectionIntentLeft(),
        LogicalKeySet(LogicalKeyboardKey.arrowRight):
            const DirectionIntentRight(),
      },
      child: Actions(
        actions: {
          DirectionIntentUp: DirectionAction(context, Direction.up),
          DirectionIntentDown: DirectionAction(context, Direction.down),
          DirectionIntentLeft: DirectionAction(context, Direction.left),
          DirectionIntentRight: DirectionAction(context, Direction.right),
        },
        child: Focus(
          child: GestureDetector(
            onVerticalDragUpdate: (details) {
              final directionZeref = ZerefProvider.of<DirectionZeref>(context);
              if (details.primaryDelta! > 0) {
                // Dragging down
                directionZeref.changeDirection(Direction.down);
              } else {
                // Dragging up
                directionZeref.changeDirection(Direction.up);
              }
            },
            onHorizontalDragUpdate: (details) {
              final directionZeref = ZerefProvider.of<DirectionZeref>(context);
              if (details.primaryDelta! > 0) {
                // Dragging right
                directionZeref.changeDirection(Direction.right);
              } else {
                // Dragging left
                directionZeref.changeDirection(Direction.left);
              }
            },
            child: Scaffold(
              backgroundColor: const Color(0xff00000f),
              body: ZerefBuilder<DirectionZeref>(
                builder: (context, state) {
                  print(state.value);
                  return Stack(
                    children: [
                      const SpaceBackGround(),
                      Stack(
                          children: List.generate(299, (index) {
                        return Positioned(
                          left: getDxDirection(
                              state.value, dx1[index].toDouble()),
                          top:
                              getDyDirection(state.value, dy[index].toDouble()),
                          child: AnimatedBuilder(
                            animation: animations[0],
                            builder: (context, child) {
                              return Transform.translate(
                                  offset: getOffset(
                                      state.value,
                                      animations[0],
                                      dx1[index].toDouble(),
                                      dy[index].toDouble() / 2),
                                  child: child);
                            },
                            child: RotatedBox(
                              quarterTurns: getDeriction(state.value),
                              child: const ShootingStar(),
                            ),
                          ),
                        );
                      })),
                      Stack(
                        children: List.generate(
                          300,
                          (index) {
                            return Positioned(
                              left: getDxDirection(
                                  state.value, dx1[index].toDouble()),
                              top: getDyDirection(
                                  state.value, dy[index].toDouble()),
                              child: AnimatedBuilder(
                                animation: animations[1],
                                builder: (context, child) {
                                  return Transform.translate(
                                      offset: getOffset(
                                          state.value,
                                          animations[1],
                                          dx2[index].toDouble(),
                                          dy[index].toDouble(),
                                          scale: 1000),
                                      child: child);
                                },
                                child: RotatedBox(
                                  quarterTurns: getDeriction(state.value),
                                  child: const ShootingStar(),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller2.dispose();
    super.dispose();
  }
}
