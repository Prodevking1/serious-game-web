import 'dart:async';

import 'package:flame_game/utils/constants.dart';
import 'package:flame_game/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomGameButton extends StatefulWidget {
  final String? text;
  final VoidCallback? onPressed;
  final Color? color;
  final Color? textColor;
  final double? borderRadius;
  final double? width;
  final double? height;

  const CustomGameButton({
    Key? key,
    this.text,
    this.onPressed,
    this.color,
    this.textColor,
    this.borderRadius,
    this.width = double.infinity,
    this.height,
  }) : super(key: key);

  @override
  State<CustomGameButton> createState() => _CustomGameButtonState();
}

class _CustomGameButtonState extends State<CustomGameButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: const Duration(seconds: 3), vsync: this)
          ..repeat(reverse: true);

    _animation = Tween<double>(begin: 0, end: 10).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final GameAudioPlayer gameAudioPlayer = Get.find();

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return InkWell(
            onTap: () async => {
              // gameAudioPlayer.playClickSound(),
              _controller.forward(from: 0),
              widget.onPressed?.call(),
            },
            child: Transform.translate(
              offset: Offset(0, 10 - _animation.value),
              child: Container(
                width: widget.width ?? double.infinity,
                height: widget.height ?? 35,
                decoration: BoxDecoration(
                    color: widget.color ?? AppColors.primaryColor,
                    borderRadius:
                        BorderRadius.circular(widget.borderRadius ?? 10),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.white,
                        spreadRadius: 1,
                        blurRadius: 0,
                        offset: Offset(0.7, 2),
                      )
                    ]),
                child: Center(
                    child: Text(widget.text ?? 'Valider',
                        textAlign: TextAlign.start,
                        style: AppTextStyles.body.copyWith(
                            color: widget.textColor ?? Colors.white))),
              ),
            ),
          );
        });
  }
}
