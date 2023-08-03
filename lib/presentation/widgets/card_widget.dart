import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final double? height;
  final double? width;
  final Widget child;
  final bool? elevation;
  final double? borderRadius;
  final borderColor;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;

  const CustomCard(
      {super.key,
      required this.child,
      this.elevation,
      this.padding,
      this.height,
      this.width,
      this.borderRadius,
      this.borderColor,
      this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: padding,
      decoration: BoxDecoration(
        boxShadow: elevation == true
            ? [
                const BoxShadow(
                  color: Colors.black,
                  spreadRadius: 1,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ]
            : null,
        color: backgroundColor ?? Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 10)),
        border: Border.all(
          color: borderColor ?? Colors.transparent,
          width: 1,
        ),
      ),
      child: child,
    );
  }
}
