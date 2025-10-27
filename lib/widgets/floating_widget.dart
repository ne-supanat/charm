import 'dart:math';

import 'package:flutter/material.dart';

class FloatingWidget extends StatefulWidget {
  const FloatingWidget({super.key, required this.child, this.duration, this.distance});

  final Widget child;
  final Duration? duration;
  final double? distance;

  @override
  State<FloatingWidget> createState() => _FloatingWidgetState();
}

class _FloatingWidgetState extends State<FloatingWidget> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration ?? Duration(seconds: 5),
      vsync: this,
    );

    _animation = Tween<double>(
      begin: -(widget.distance ?? 10 / 2),
      end: (widget.distance ?? 10 / 2),
    ).chain(CurveTween(curve: Curves.easeInOut)).animate(_controller);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Future.delayed(Duration(milliseconds: (Random().nextDouble() * 1000).toInt()));
      _controller.repeat(reverse: true);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(offset: Offset(0, _animation.value), child: child);
      },
      child: widget.child,
    );
  }
}
