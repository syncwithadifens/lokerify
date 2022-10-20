import 'package:flutter/material.dart';
import 'package:lokerify/theme/styles.dart';

class Avatar extends StatelessWidget {
  final double w;
  final double h;
  const Avatar({
    Key? key,
    required this.h,
    required this.w,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: w + 10,
          height: h + 10,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: whiteColor,
              border: Border.all(color: primaryColor)),
        ),
        Container(
          width: w,
          height: h,
          decoration: BoxDecoration(shape: BoxShape.circle, color: whiteColor),
        )
      ],
    );
  }
}
