import 'package:flutter/material.dart';

class GradientDivider extends StatelessWidget {
  final bool reverse;
  final double? width;
  final Color color;

  const GradientDivider({
    super.key,
    this.reverse = false,
    this.width,
    this.color = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 1.5,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: reverse ? Alignment.centerRight : Alignment.centerLeft,
          end: reverse ? Alignment.centerLeft : Alignment.centerRight,
          colors: const [
            Colors.transparent,
            Colors.black26,
          ],
        ),
      ),
    );
  }
}
