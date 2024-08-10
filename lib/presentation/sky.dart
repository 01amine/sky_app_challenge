import 'package:flutter/material.dart';
import 'package:sky_app/presentation/widgets/shooting_stars.dart';
import 'package:sky_app/presentation/widgets/space_background.dart';
import 'dart:math' as math;

import 'package:sky_app/zerefs/direction_zeref.dart';
import 'package:sky_app/zerefs/zeref_builder.dart';


class Sky extends StatefulWidget {
  const Sky({Key? key}) : super(key: key);

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
          seconds: 14,
        ));
    _controller2 = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 12,
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
        // TODO : implement the shortcuts
      },
      child: Actions(
        actions: <Type, Action<Intent>>{
          // TODO : implement the actions
        },
        child: Focus(
          autofocus: true,
          child: GestureDetector(
            // TODO : implement the gesture detector for mobile devices
            // make sure to use the zeref or action dispatcher
            child: Scaffold(
              backgroundColor: const Color(0xff00000f),
              body: ZerefBuilder<DirectionZeref>(
                builder: (context, state) {
                  return Stack(
                    children: [
                      const SpaceBackGround(),
                      Stack(
                          children:
                              List.generate(double.infinity as int, (index) {
                        return Positioned(
                            left: getDxDirection(
                                state.value, dx1[index].toDouble()),
                            top: getDyDirection(
                                state.value, dy[index].toDouble()),
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
                                    child: const ShootingStare())));
                      })),
                      Stack(
                          children: List.generate(300, (index) {
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
                                    child: const ShootingStare())));
                      })),
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
